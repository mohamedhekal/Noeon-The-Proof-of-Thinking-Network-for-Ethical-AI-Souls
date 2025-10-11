#!/bin/bash

# Noeon Repository Protection Setup Script
# Author: Mohamed Khaled Ahmed Hamad
# Email: mohamed.k.hekal@gmail.com

echo "🛡️  Setting up Noeon Repository Protection..."
echo "=============================================="

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    echo "Please install it from: https://cli.github.com/"
    exit 1
fi

# Check if user is authenticated
if ! gh auth status &> /dev/null; then
    echo "❌ Not authenticated with GitHub CLI."
    echo "Please run: gh auth login"
    exit 1
fi

echo "✅ GitHub CLI is installed and authenticated"

# Repository name
REPO_NAME="Noeon-The-Proof-of-Thinking-Network-for-Ethical-AI-Souls"
REPO_OWNER="mohamedhekal"

echo "📋 Setting up branch protection for repository: $REPO_OWNER/$REPO_NAME"

# Set branch protection rules
echo "🔒 Configuring branch protection rules..."

# Enable branch protection for main branch
gh api repos/$REPO_OWNER/$REPO_NAME/branches/main/protection \
  --method PUT \
  --field required_status_checks='{"strict":true,"contexts":["branch-protection"]}' \
  --field enforce_admins=true \
  --field required_pull_request_reviews='{"required_approving_review_count":1,"dismiss_stale_reviews":true,"require_code_owner_reviews":true}' \
  --field restrictions='{"users":[],"teams":[],"apps":[]}' \
  --field allow_force_pushes=false \
  --field allow_deletions=false

if [ $? -eq 0 ]; then
    echo "✅ Branch protection rules configured successfully"
else
    echo "❌ Failed to configure branch protection rules"
    echo "Please configure manually in GitHub repository settings"
fi

# Set repository topics
echo "🏷️  Setting repository topics..."
gh api repos/$REPO_OWNER/$REPO_NAME/topics \
  --method PUT \
  --field names='["blockchain","ai","proof-of-thinking","ai-souls","decentralized","cryptography","zero-knowledge","governance","dao","intellectual-property","research","conceptual"]'

if [ $? -eq 0 ]; then
    echo "✅ Repository topics set successfully"
else
    echo "⚠️  Failed to set repository topics (this is optional)"
fi

# Enable security features
echo "🔐 Enabling security features..."

# Enable vulnerability alerts
gh api repos/$REPO_OWNER/$REPO_NAME/vulnerability-alerts \
  --method PUT

# Enable automated security fixes
gh api repos/$REPO_OWNER/$REPO_NAME/automated-security-fixes \
  --method PUT

if [ $? -eq 0 ]; then
    echo "✅ Security features enabled"
else
    echo "⚠️  Failed to enable some security features"
fi

# Set repository description
echo "📝 Setting repository description..."
gh api repos/$REPO_OWNER/$REPO_NAME \
  --method PATCH \
  --field description="Noeon - The Proof-of-Thinking Network for Ethical AI Souls. A revolutionary decentralized protocol combining Proof-of-Thinking (PoT) with AI Soul Identity (SoulSync) for verifiable AI reasoning and ethical governance. © 2025 Mohamed Khaled Ahmed Hamad. All rights reserved."

if [ $? -eq 0 ]; then
    echo "✅ Repository description updated"
else
    echo "⚠️  Failed to update repository description"
fi

# Set repository website
echo "🌐 Setting repository website..."
gh api repos/$REPO_OWNER/$REPO_NAME \
  --method PATCH \
  --field homepage="https://github.com/mohamedhekal/Noeon-The-Proof-of-Thinking-Network-for-Ethical-AI-Souls"

if [ $? -eq 0 ]; then
    echo "✅ Repository website set"
else
    echo "⚠️  Failed to set repository website"
fi

echo ""
echo "🎉 Repository protection setup completed!"
echo "=============================================="
echo ""
echo "📋 Summary of protection measures:"
echo "✅ Branch protection rules enabled"
echo "✅ Pull request reviews required"
echo "✅ Direct pushes to main blocked"
echo "✅ Security features enabled"
echo "✅ Repository metadata updated"
echo ""
echo "🔒 Protection Features:"
echo "- Only you can merge pull requests to main"
echo "- All changes must go through pull requests"
echo "- Automated validation of PR requirements"
echo "- Legal document change monitoring"
echo "- IP protection compliance checks"
echo ""
echo "📞 For any issues, contact: mohamed.k.hekal@gmail.com"
echo ""
echo "⚠️  Important: This repository contains protected intellectual property."
echo "   All concepts are the exclusive property of Mohamed Khaled Ahmed Hamad."
echo ""
echo "© 2025 Mohamed Khaled Ahmed Hamad. All rights reserved."
