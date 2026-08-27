# -*- coding: utf-8 -*-
# vim: ft=sls
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide
    with context %}

{%- for conf_path in vscode_ide.config.keys() %}

Remove Visual Studio Code Configuration File {{ conf_path }}:
  file.absent:
    - name: {{ conf_path }}

{%- endfor %}
