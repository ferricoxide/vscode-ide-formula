# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}

include:
{%- if grains.kernel == "Linux" %}
  - vscode-ide.package.lin_install
{%- elif grains.kernel == "Windows" %}
  - vscode-ide.package.winrepo
  - vscode-ide.package.win_install
{%- endif %}

Avoid being a null-router (package/install) - VSCode IDE:
  test.nop: []
