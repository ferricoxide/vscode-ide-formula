# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

vscode-ide-config-file-file-managed:
  file.managed:
    - name: {{ vscode_ide.config }}
    - source: {{ files_switch(['example.tmpl'],
                              lookup='vscode-ide-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ vscode_ide.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        vscode_ide: {{ vscode_ide | json }}
