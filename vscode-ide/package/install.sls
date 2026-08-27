# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}

vscode-ide-package-install-pkg-installed:
  pkg.installed:
    - name: {{ vscode_ide.pkg.name }}
