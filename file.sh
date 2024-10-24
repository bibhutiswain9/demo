#!/bin/bash

# Step 1: Change files
for i in {1..10}; do
  echo "Making changes to file$i.txt" >> file$i.txt
done

# Step 2: Git Add and Commit
git add .
git commit -m "Updated 10 files"

# Step 3: Create new branch and check if it exists on remote
BRANCH_NAME="update-10-files"

# Check if the branch already exists on remote, if yes, rebase it
if git ls-remote --exit-code origin $BRANCH_NAME; then
  echo "Branch $BRANCH_NAME exists on remote, pulling remote changes..."
  git fetch origin $BRANCH_NAME
  git checkout $BRANCH_NAME
  git rebase origin/$BRANCH_NAME
else
  git checkout -b $BRANCH_NAME
fi

# Push the branch to the remote
git push origin $BRANCH_NAME --force

# Step 4: Create a Pull Request (no --json flag to avoid unknown flag issue)
gh pr create --title "Feature: Updated 10 files" --body "This PR updates 10 files" --base main --head $BRANCH_NAME

# Step 5: Merge the PR
gh pr merge $BRANCH_NAME --squash --delete-branch --comment "Merging this PR with squash."

# Step 6: Cleanup (switch to main branch and delete local branch)
git checkout main
git pull origin main
git branch -D $BRANCH_NAME
