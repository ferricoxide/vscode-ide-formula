# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}

Remove Visual Studio Code Configuration File:
  file.absent:
    - name: {{ vscode_ide.config }}
