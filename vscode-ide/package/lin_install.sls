# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}

Install Visual Studio Code Package:
  pkg.installed:
    - name: {{ vscode_ide.pkg.name }}
{%- if 'repo' in vscode_ide.pkg and vscode_ide.pkg.repo %}
    - require:
      - pkgrepo: Manage Visual Studio Code Repository

Manage Visual Studio Code Repository:
  pkgrepo.managed:
    - baseurl: {{ vscode_ide.pkg.repo.baseurl }}
    - enabled: {{ vscode_ide.pkg.repo.enabled }}
    - gpgcheck: {{ vscode_ide.pkg.repo.gpgcheck }}
    - gpgkey: {{ vscode_ide.pkg.repo.gpgkey }}
    - name: {{ vscode_ide.pkg.repo.name }}
    - summary: {{ vscode_ide.pkg.repo.summary }}
{%- endif %}
