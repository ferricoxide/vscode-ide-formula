# -*- coding: utf-8 -*-
# vim: ft=sls
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}
{%- set config_map = vscode_ide.get('config') or {} %}
{%- set create_desktop_shortcut =
        config_map.get('desktop_shortcut', false) %}
{%- set target_binary = 'C:/Program Files/Microsoft VS Code/Code.exe' %}
{%- set target_dir = 'C:/Program Files/Microsoft VS Code' %}
{%- set public_desktop = 'C:/Users/Public/Desktop' %}

include:
  - {{ sls_package_install }}

{%- if create_desktop_shortcut %}

Ensure Public Desktop Directory Exists:
  file.directory:
    - makedirs: True
    - name: '{{ public_desktop }}'

Manage Desktop Launcher Shortcut:
  shortcut.present:
    - arguments: ''
    - description: 'Visual Studio Code'
    - icon_index: 0
    - icon_location: '{{ target_binary }}'
    - name: '{{ public_desktop }}/Visual Studio Code.lnk'
    - require:
      - file: 'Ensure Public Desktop Directory Exists'
      - sls: {{ sls_package_install }}
    - target: '{{ target_binary }}'
    - working_dir: '{{ target_dir }}'

{%- endif %}

{%- for conf_path, conf_content in vscode_ide.config.items() %}
{%- if conf_content is mapping %}

Manage Visual Studio Code Configuration File {{ conf_path }}:
  file.serialize:
    - dataset: {{ conf_content | json }}
    - makedirs: True
    - name: {{ conf_path }}
    - require:
      - sls: {{ sls_package_install }}
    - serializer: json
{%- endif %}
{%- endfor %}
