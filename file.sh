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
PR_URL=$(gh pr create --title "Feature: Updated 10 files" --body "This PR updates 10 files" --base main --head $BRANCH_NAME --json url -q ".url")

echo "Pull Request created: $PR_URL"

# Step 5: Close the PR without merging
gh pr close $BRANCH_NAME --comment "Closing this PR without merging."

# Step 6: Delete the branch locally
git checkout main
git branch -D $BRANCH_NAME
