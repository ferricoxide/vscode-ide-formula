# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}

include:
  - {{ sls_config_clean }}
{%- if grains.kernel == "Linux" %}
  - vscode-ide.package.lin_clean
{%- elif grains.kernel == "Windows" %}
  - vscode-ide.package.win_clean
{%- endif %}

Avoid being a null-router (package/clean) - VSCode IDE:
  test.nop: []
