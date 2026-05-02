.ONESHELL:
.PHONY: setup install refresh

setup:
	pipx install --include-deps ansible==11.7.0

install:
	ansible-playbook \
		--connection local \
		--extra-vars distfiles_dir="$(XDG_CACHE_HOME)/distfiles" \
		--skip-tags optional \
		$(PLAYBOOK)

refresh:
	find "$(XDG_CACHE_HOME)/distfiles" -mindepth 1 -maxdepth 1 -type d | sort | while read repo; do
		if ! git -C "$$repo" rev-parse --is-inside-git-dir > /dev/null 2>&1; then
			continue
		fi

		name=$$(basename "$$repo")
		commit=$$(git -C "$$repo" ls-remote origin HEAD | cut -f1) || {
			echo "Fetch failed: $$repo" >&2
			continue
		}

		jq --null-input --compact-output --arg name "$$name" --arg commit "$$commit" '{$$name, $$commit}'
	done > env-lock.jsonl
