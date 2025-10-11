#!/bin/bash

git ls-files -m -z > /tmp/files.txt
git ls-files --others --exclude-standard -z >> /tmp/files.txt

if [ ! -s /tmp/files.txt ]; then
  echo "✅ No changes to commit."
  exit 0
fi

while IFS= read -r -d '' file; do
  git add "$file"
  git commit -m "Commit: $file"
done < /tmp/files.txt

git push origin main
