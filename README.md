# env

Ansible notebooks for building programs along with their dependencies from source.

## Installation

```sh
./setup.sh
```

## Dependencies

* [pipx]

## Cache

Before invoking the `install.sh` script make sure to clean Ansible's cache:

```sh
rm -rf "${XDG_CACHE_HOME:-$HOME/.cache/ansible}"
```

The cache might contain old versions of modules that `ansible-playbook` might resolve and use.

For example, an issue was observed with `community.general.cargo` module. A recent version of the module accepts `directory` option that is not available in earlier versions.
