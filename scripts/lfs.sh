# !usr/bin/bash

brew install git-lfs

# in a repo
git lfs install

git lfs track "*.psd"
git add .gitattributes

git add file.psd
git commit -m "Add design file"
git push origin main

# Check for large files and existing Git LFS objects in your local main branch
git lfs migrate info --include-ref=main

# Check for large files and existing Git LFS objects in every branch
$ git lfs migrate info --everything