#!/bin/bash

# GitHub Repository Setup Script for PDF2AudioBook
# This script helps you create a GitHub repository and push your code

set -e  # Exit on error

echo "=========================================="
echo "PDF2AudioBook - GitHub Repository Setup"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
REPO_NAME="pdf2audiobook"
REPO_DESCRIPTION="A production-ready SaaS platform for converting PDF documents to high-quality audiobooks using advanced OCR and text-to-speech technology"
GITHUB_USERNAME="cdarwin7"

echo -e "${BLUE}Repository Name:${NC} $REPO_NAME"
echo -e "${BLUE}Description:${NC} $REPO_DESCRIPTION"
echo -e "${BLUE}GitHub Username:${NC} $GITHUB_USERNAME"
echo ""

# Check if GitHub CLI is installed
if command -v gh &> /dev/null; then
    echo -e "${GREEN}✓${NC} GitHub CLI (gh) is installed"

    # Check if user is authenticated
    if gh auth status &> /dev/null; then
        echo -e "${GREEN}✓${NC} You are authenticated with GitHub CLI"
        echo ""

        # Ask user if they want to create the repo
        read -p "Do you want to create the GitHub repository now? (y/n): " -n 1 -r
        echo

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo ""
            echo -e "${BLUE}Creating GitHub repository...${NC}"

            # Create the repository
            gh repo create "$REPO_NAME" \
                --public \
                --description "$REPO_DESCRIPTION" \
                --source=. \
                --remote=origin \
                --push

            echo ""
            echo -e "${GREEN}✓${NC} Repository created successfully!"
            echo -e "${GREEN}✓${NC} Code pushed to GitHub!"
            echo ""
            echo -e "${BLUE}Repository URL:${NC} https://github.com/$GITHUB_USERNAME/$REPO_NAME"
            echo ""
            echo "Next steps:"
            echo "1. Visit your repository at: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
            echo "2. Add repository secrets for CI/CD (if needed)"
            echo "3. Configure branch protection rules (recommended)"
            echo "4. Set up GitHub Actions workflows"
            echo ""
        else
            echo ""
            echo -e "${YELLOW}Repository creation cancelled.${NC}"
            echo ""
            echo "To create the repository manually later, run:"
            echo "  gh repo create $REPO_NAME --public --description \"$REPO_DESCRIPTION\" --source=. --remote=origin --push"
            echo ""
        fi
    else
        echo -e "${YELLOW}⚠${NC}  You are not authenticated with GitHub CLI"
        echo ""
        echo "Please authenticate first by running:"
        echo "  gh auth login"
        echo ""
        echo "Then run this script again."
        exit 1
    fi
else
    echo -e "${YELLOW}⚠${NC}  GitHub CLI (gh) is not installed"
    echo ""
    echo "Option 1: Install GitHub CLI (Recommended)"
    echo "=========================================="
    echo "Install GitHub CLI from: https://cli.github.com/"
    echo ""
    echo "Linux/WSL:"
    echo "  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg"
    echo "  echo \"deb [arch=\$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main\" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null"
    echo "  sudo apt update"
    echo "  sudo apt install gh"
    echo ""
    echo "macOS:"
    echo "  brew install gh"
    echo ""
    echo "After installation, run:"
    echo "  gh auth login"
    echo "  ./setup-github-repo.sh"
    echo ""
    echo "Option 2: Manual Setup"
    echo "======================"
    echo ""
    echo "1. Go to: https://github.com/new"
    echo "2. Repository name: $REPO_NAME"
    echo "3. Description: $REPO_DESCRIPTION"
    echo "4. Choose: Public"
    echo "5. Do NOT initialize with README, .gitignore, or license (we already have these)"
    echo "6. Click 'Create repository'"
    echo ""
    echo "Then run these commands:"
    echo ""
    echo "  git remote add origin https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
    echo "  git push -u origin main"
    echo ""
fi

echo "=========================================="
echo ""

# Display current git status
echo -e "${BLUE}Current Git Status:${NC}"
git status
echo ""

# Display helpful information
echo -e "${BLUE}Helpful Git Commands:${NC}"
echo "  git status              - Check status of your repository"
echo "  git add .               - Stage all changes"
echo "  git commit -m 'msg'     - Commit changes"
echo "  git push                - Push to GitHub"
echo "  git pull                - Pull latest changes"
echo "  git log --oneline       - View commit history"
echo ""

echo -e "${GREEN}Setup complete!${NC}"
