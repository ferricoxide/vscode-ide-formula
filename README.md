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

## Testing

Primary integration-testing is done at the git repository-server. For this
project's "upstream" home, the repository-server is GitHub.com. This primary
integration-testing is handled primarily via GitHub actions.

Local integration-testing may be executed via Test Kitchen and Chef InSpec.
This may be done directly on the local host or against containerized Salt
minion instances. Local integration-testing is recommended to help reduce the
likelihood that server-side testing will fail when submitting pull-requests.

### Local Testing with Podman

If your development workstation lacks Ruby or native Test Kitchen tooling,
you can execute the test suite inside a rootless Podman runner container:

1.  Enable the user-level Podman socket:

    ```bash
    systemctl --user enable --now podman.socket
    ```

2.  Execute Kitchen verification[^1]:

    ```bash
    podman run \
      --rm \
      -it \
      --network host \
      -v /run/user/$( id -u )/podman/podman.sock:/var/run/docker.sock \
      -v "$PWD":/workspace:Z \
      -w /workspace \
      -e DOCKER_HOST=unix:///var/run/docker.sock \
      -e DOCKER_BUILDKIT=0 docker.io/techneg/ci-docker-python-ruby:latest \
      bash -c "bundle install && bundle exec kitchen verify almalinux-9-latest"
    ```

## Compatibility Notes:

### Linux

Should work on all Enterprise Linux and derived distros that leverage `dnf`.
However, project-content has only been specifically testd on Enterprise Linux 8
and 9 variants (RHEL, AlmaLinux, Rocky Linux, CentOS Stream).

Similary, while `dnf`-based installations _should_ work with vendor and private
repositories, the method was only specifically tested using the official
Microsoft YUM repositories.

### Windows

Should work with self-hosted installer-files and for arbitrary
version-specificatons. However, it was only specifically tested on Windows
Server 2022 using the official, Microsoft-hosted installers and only requested
the "latest" version. As such, download-sources were identified using dynamic
queries of the VSCode Update API to build local winrepo package definitions and
installs machine-wide to `C:\Program Files`.

[^1]: While this project's `kitchen.yaml` file has mappings for Alma and Rocky
    Linux 10, using them currently does not work. The necessary (official)
    Docker images do not exist on Docker Hub. The upstream saltstack-formulas
    project-owners maintain pre-salted test images for Enterprise Linux 8 and 9
    (AlmaLinux, Rocky Linux, RHEL, CentOS Stream).  However, as of this README's
    writings, EL10 images have not yet been built or tagged.
