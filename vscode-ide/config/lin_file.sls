# -*- coding: utf-8 -*-
# vim: ft=sls
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}
include:
  - {{ sls_package_install }}

{%- for conf_path, conf_content in vscode_ide.config.items() %}

Manage Visual Studio Code Configuration File {{ conf_path }}:
  file.serialize:
    - dataset: {{ conf_content | json }}
    - group: {{ vscode_ide.rootgroup }}
    - makedirs: True
    - mode: '0644'
    - name: {{ conf_path }}
    - require:
      - sls: {{ sls_package_install }}
    - serializer: json
    - user: root

{%- endfor %}
