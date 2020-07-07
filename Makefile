.DEFAULT_GOAL:= help
.PHONY: help
help:
	@echo 'Usage: make <subcommand>'
	@echo ''
	@echo 'Subcommands:'
	@echo '    test            Check style for Bash with shellcheck'

.PHONY: test
test:
	shellcheck bin/*