vscode-ide-formula
==================

A SaltStack formula designed to install and configure the [VSCode IDE package](https://code.visualstudio.com/) on installation-targets.

It is primarily expected that this formula will be run via [P3](https://www.plus3it.com/)'s "[watchmaker](https://watchmaker.readthedocs.io/en/stable/)" framework.

## Available states

- [vscode-ide](#vscode-ide)
- [vscode-ide.clean](#vscode-ide.clean)
- [vscode-ide.package](#vscode-ide.package)
- [vscode-ide.package.clean](#vscode-ide.package.clean)
- [vscode-ide.config](#vscode-ide.config)
- [vscode-ide.config.clean](#vscode-ide.config.clean)

### vscode-ide

Executes the `package` and `config` states to install and configure the VSCode IDE

### vscode-ide.clean

Executes the `package` and `config` states' `clean` actions to fully uninstall the VSCode IDE and remove previously-installed browser policy-configs (and, on Windows, associated registry entries)

### vscode-ide.package

Executes _just_ the `package` state to install the VSCode IDE package.

### vscode-ide.package.clean

Executes _just_ the `package.clean` state to uninstall the VSCode IDE package.

### vscode-ide.config

Executes _just_ the `config` state to install/configure the VSCode IDE client-configuration (etc.) files

### vscode-ide.config.clean

Executes _just_ the `config` state to uninstall the VSCode IDE client-configuration (etc.) files and, on Windows, remove any registry-keys set by prior install-runs of the formula.

## Compatibility Notes:

### Linux

### Windows

