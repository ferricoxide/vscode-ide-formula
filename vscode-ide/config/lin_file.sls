# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

Manage Visual Studio Code Configuration File:
  file.managed:
    - context:
        vscode_ide: {{ vscode_ide | json }}
    - group: {{ vscode_ide.rootgroup }}
    - mode: 644
    - name: {{ vscode_ide.config }}
    - require:
      - sls: {{ sls_package_install }}
    - source: {{ files_switch(['example.tmpl'],
                               lookup='Manage Visual Studio Code'
                                      ~ ' Configuration File'
                )
              }}
    - template: jinja
