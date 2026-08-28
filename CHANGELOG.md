## vscode-ide-formula

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## 0.1.1

**Released**: 2026.08.28

**Summary**:

*   Add support for Windows Server targets.
*   Implement dynamic `winrepo` definition generation and local database
    compilation using `winrepo.genrepo`. Allow override by setting a new
    `download_uri` parameter and value in Pillar
*   Implement cross-platform configuration serialization via `file.serialize`.
*   Add optional public desktop shortcut creation using `shortcut.present`
    controlled via the `desktop_shortcut` parameter. Default is "false" for "no
    desktop shortcut"

## 0.1.0

**Released**: 2026.08.27

**Summary**:

*   Add RHEL/Linux support for VSCode package installation via native
    `pkg.installed` and `pkgrepo.managed` states.
*   Implement dynamic, parameter-driven system-wide configuration management
    using `file.serialize` driven by `vscode-ide/parameters/os_family/RedHat.yaml`.
*   Add Chef InSpec integration test controls in `test/integration/default/` to
    verify package and filesystem state.
*   Define Test Kitchen harness supporting local containerized test runs via Podman.

### 0.0.1

**Released**: 2026.08.27

**Summary**:
*   Cloned project from https://github.com/plus3it/repo-template
*   Created vscode-ide directory-tree contents by:
    1.  Cloning https://github.com/saltstack-formulas/template-formula.git
    2.  Executing `bin/convert-formula.sh vscode-ide` in the new repo-copy
    3.  Moving the resulting `vscode-ide` directory into this project's space
    4.  Updating all imports from "`vscode__ide`" to "`vscode_ide`"
*   Update [LICENSE](LICENSE), CHANGELOG.md (this file), [README.md](README.md)
    and [.bumpversion.cfg](.bumpversion.cfg) per the P3 repo-template guidance
*   Update the `.github` and `tests` directories' contents per the P3
    repo-template guidance
