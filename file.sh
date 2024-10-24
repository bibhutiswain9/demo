#!/bin/bash

# Step 1: Change files
for i in {1..10}; do
  echo "Making changes to file$i.txt" >> file$i.txt
done

# Step 2: Git Add and Commit
git add .
git commit -m "Updated 10 files"

# Step 3: Create new branch and push
BRANCH_NAME="update-10-files"
git checkout -b $BRANCH_NAME
git push origin $BRANCH_NAME

# Step 4: Create a Pull Request
gh pr create --title "Feature: Updated 10 files" --body "This PR updates 10 files" --base main --head $BRANCH_NAME

# Step 5: Merge PR (optional) or close PR
# gh pr merge --squash --delete-branch
# gh pr close $BRANCH_NAME
