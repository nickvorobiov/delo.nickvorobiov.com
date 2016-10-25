#!/bin/bash

if [[ $TRAVIS_BRANCH == 'gh-pages' ]] ; then
  cd _site

  printenv

  # We redirect any output to
  # /dev/null to hide any sensitive credential data that might otherwise be exposed.
  #git push --force --quiet "https://${git_user}:${git_password}@${git_target}" master:master > /dev/null 2>&1

  chmod 600 deploy-key
  mv deploy-key ~/.ssh/id_rsa

  rsync -a -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet" --quiet --omit-dir-times --update --delete --delay-updates _site/ ${DEPLOY_ADR}

else
  echo 'Invalid branch. You can only deploy from gh-pages.'
  exit 1
fi