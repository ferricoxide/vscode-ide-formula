# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}

include:
{%- if grains.kernel == "Linux" %}
  - vscode-ide.config.lin_clean
{%- elif grains.kernel == "Windows" %}
  - vscode-ide.config.win_clean
{%- endif %}

Avoid being a null-router (config/clean) - VSCode IDE:
  test.nop: []
