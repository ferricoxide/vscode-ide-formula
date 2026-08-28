# -*- coding: utf-8 -*-
# vim: ft=sls
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}
{%- set pkg_map = vscode_ide.get('pkg') or {} %}
{%- set pkg_name = pkg_map.get('name', 'vscode') %}
{%- set winrepo_local_dir = salt['config.get'](
        'winrepo_dir',
        'C:/Watchmaker/Salt/srv/winrepo/winrepo'
) %}
{%- set winrepo_file = winrepo_local_dir ~ '/' ~
        pkg_name | lower ~ '.sls' %}

include:
  - {{ sls_config_clean }}

Compile Local Winrepo Database After Deletion:
  module.run:
    - onchanges:
      - file: 'Remove Vs Code Winrepo Definition File'
    - winrepo.genrepo: []

Refresh Minion Package Manager Database Cache After Deletion:
  module.run:
    - onchanges:
      - module: 'Compile Local Winrepo Database After Deletion'
    - pkg.refresh_db: []

Remove Vs Code Package:
  pkg.removed:
    - name: '{{ pkg_name }}'
    - require:
      - sls: {{ sls_config_clean }}
    - require_in:
      - file: 'Remove Vs Code Winrepo Definition File'

Remove Vs Code Winrepo Definition File:
  file.absent:
    - name: '{{ winrepo_file }}'
