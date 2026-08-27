# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}

include:
  - {{ sls_config_clean }}

Remove Visual Studio Code Package:
  pkg.removed:
    - name: {{ vscode_ide.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}

{%- if 'repo' in vscode_ide.pkg and vscode_ide.pkg.repo %}

Remove Visual Studio Code Repository:
  pkgrepo.absent:
    - name: {{ vscode_ide.pkg.repo.name }}
    - require:
      - pkg: Remove Visual Studio Code Package
{%- endif %}
