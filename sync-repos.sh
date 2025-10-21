#!/bin/bash
# sync-repos.sh
# V0.1 vom 2025-10-21

set -e  # Script bei Fehlern abbrechen

echo "Fetching from all remotes..."
git fetch --all

echo "Current status:"
git status

echo "Merging forgejo/main..."
if ! git merge forgejo/master; then
    echo "❌ Merge conflict with forgejo! Please resolve manually."
    exit 1
fi

echo "Merging github/main..."
if ! git merge github/master; then
    echo "❌ Merge conflict with github! Please resolve manually."
    exit 1
fi

echo "Merging codeberg/main..."
if ! git merge codeberg/master; then
    echo "❌ Merge conflict with codeberg! Please resolve manually."
    exit 1
fi

echo "Pushing to all remotes..."
git push forgejo master
git push github master
git push codeberg master

echo "✅ Sync complete!"
