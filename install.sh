#!/usr/bin/env sh

ansible-playbook \
  --connection local \
  --extra-vars distfiles_dir="$XDG_CACHE_HOME/distfiles" \
  --skip-tags optional \
  "$PLAYBOOK"
