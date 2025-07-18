<div align="center">

# asdf-gomplate [![Build](https://github.com/sneakybeaky/asdf-gomplate/actions/workflows/build.yml/badge.svg)](https://github.com/sneakybeaky/asdf-gomplate/actions/workflows/build.yml) [![Lint](https://github.com/sneakybeaky/asdf-gomplate/actions/workflows/lint.yml/badge.svg)](https://github.com/sneakybeaky/asdf-gomplate/actions/workflows/lint.yml)

[gomplate](https://docs.gomplate.ca/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

# Install

Plugin:

```shell
asdf plugin add gomplate
# or
asdf plugin add gomplate https://github.com/sneakybeaky/asdf-gomplate.git
```

gomplate:

```shell
# Show all installable versions
asdf list-all gomplate

# Install specific version
asdf install gomplate latest

# Set a version globally (on your ~/.tool-versions file)
asdf global gomplate latest

# Now gomplate commands are available
gomplate -v
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/sneakybeaky/asdf-gomplate/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Jon Barber](https://github.com/sneakybeaky/)
