#!/bin/bash
set -e

echo "=== Manual Database Migration Script ==="
echo ""

# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
    echo "ERROR: DATABASE_URL environment variable is not set"
    echo "Please set it with: export DATABASE_URL='your_database_url'"
    exit 1
fi

echo "DATABASE_URL is set: ${DATABASE_URL:0:30}..."
echo ""

# Check if alembic.ini exists
if [ ! -f "alembic.ini" ]; then
    echo "ERROR: alembic.ini not found in current directory"
    echo "Please run this script from the project root directory"
    exit 1
fi

echo "✅ Found alembic.ini"
echo ""

# Check current database state
echo "Checking database state..."
echo ""

# Try to query the users table
if psql "$DATABASE_URL" -c "\d users" > /dev/null 2>&1; then
    echo "✅ Users table exists"
    psql "$DATABASE_URL" -c "\d users"
else
    echo "❌ Users table does NOT exist - migrations need to be run"
fi

echo ""
echo "---"
echo ""

# Ask for confirmation
read -p "Do you want to run migrations now? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Migration cancelled"
    exit 0
fi

echo ""
echo "Running Alembic migrations..."
echo ""

# Run migrations
alembic upgrade head

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Migrations completed successfully!"
    echo ""
    echo "Verifying database state..."
    psql "$DATABASE_URL" -c "\dt"
else
    echo ""
    echo "❌ Migration failed!"
    exit 1
fi
