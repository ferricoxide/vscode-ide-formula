# -*- coding: utf-8 -*-
# vim: ft=sls
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}
{%- set pkg_map = vscode_ide.get('pkg') or {} %}
{%- set package_name = pkg_map.get('name', 'vscode') %}

Install Visual Studio Code Package:
  pkg.installed:
    - name: '{{ package_name }}'
