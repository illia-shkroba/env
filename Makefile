.PHONY: setup install

setup:
	pipx install --include-deps ansible==11.7.0

install:
	ansible-playbook \
		--connection local \
		--extra-vars distfiles_dir="$(XDG_CACHE_HOME)/distfiles" \
		--skip-tags optional \
		$(PLAYBOOK)
