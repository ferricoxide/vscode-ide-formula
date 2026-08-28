# -*- coding: utf-8 -*-
# vim: ft=sls
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}

{%- set public_desktop = 'C:/Users/Public/Desktop' %}

Remove Desktop Launcher Shortcut:
  file.absent:
    - name: '{{ public_desktop }}/Visual Studio Code.lnk'

{%- for conf_path, conf_content in vscode_ide.config.items() %}
{%- if conf_content is mapping %}

Remove Visual Studio Code Configuration File {{ conf_path }}:
  file.absent:
    - name: {{ conf_path }}
{%- endif %}
{%- endfor %}
