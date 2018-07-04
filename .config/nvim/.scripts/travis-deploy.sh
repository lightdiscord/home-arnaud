#!/usr/bin/env bash

set -e

setup_git() {
    git config --global user.email "deploy@travis-ci.org"
    git config --global user.name "Deployment Bot"
}

commit() {
    git checkout -b build
    git add .
    git commit -m "Travis build: $TRAVIS_BUILD_NUMBER"
}

push() {
    git remote add origin-build https://${GITHUB_TOKEN}@github.com/LightDiscord/Vim-files.git > /dev/null 2>&1
    git push --quiet --force -u origin-build build
}

cp -rL result dist
chmod -R u+w dist

cd dist

setup_git
commit
push

cd -
