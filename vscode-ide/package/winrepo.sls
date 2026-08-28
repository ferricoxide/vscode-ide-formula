# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as vscode_ide with context %}
{%- set pkg_map = vscode_ide.get('pkg') or {} %}
{%- set full_name_override = pkg_map.get('full_name') %}
{%- set pkg_name = pkg_map.get('name', 'vscode') %}
{%- set vscode_download_uri = pkg_map.get('download_uri') %}
{%- set vscode_version = pkg_map.get('version') %}

{#- Query VSCode Update API for latest release details if omitted #}
{%- if not vscode_download_uri or not vscode_version %}
  {%- set api_url = 'https://update.code.visualstudio.com/api/update/' ~
          'win32-x64/stable/latest' %}
  {%- set api_res = salt['http.query'](
          api_url,
          decode=True,
          decode_type='json'
  ) %}
  {%- if 'dict' in api_res and api_res['dict'] %}
    {%- if not vscode_version and 'name' in api_res['dict'] %}
      {%- set vscode_version = api_res['dict']['name'] %}
    {%- endif %}
    {%- if not vscode_download_uri and 'url' in api_res['dict'] %}
      {%- set vscode_download_uri = api_res['dict']['url'] %}
    {%- endif %}
  {%- endif %}
  {#- Fallback URL if API response lacked direct URL string #}
  {%- if not vscode_download_uri %}
    {%- set vscode_download_uri = 'https://update.code.visualstudio.com/' ~
            'latest/win32-x64/stable' %}
  {%- endif %}
{%- endif %}

{%- if not vscode_version %}

Enforce Explicit Version Contract:
  test.fail_without_changes:
    - name: 'Unable to determine VSCode version. Define version in Pillar.'

{%- else %}
  {%- set winrepo_local_dir = salt['config.get'](
          'winrepo_dir',
          'C:/Watchmaker/Salt/srv/winrepo/winrepo'
  ) %}
  {%- set winrepo_file = winrepo_local_dir ~ '/' ~
          pkg_name | lower ~ '.sls' %}
  {%- set win_version = vscode_version ~ '.0' if
          vscode_version.count('.') < 3 else
          vscode_version %}
  {%- set default_full_name = 'Microsoft Visual Studio Code' %}
  {%- set full_name = full_name_override if full_name_override else
          default_full_name %}

Compile Local Winrepo Database:
  cmd.run:
    - name: |
        $cmd = (Get-Command salt-call.exe -ErrorAction SilentlyContinue).Path
        if (-not $cmd) {
          $paths = @(
            "${env:ProgramFiles}\Salt Project\Salt\salt-call.exe",
            "C:\Watchmaker\Salt\salt-call.exe",
            "C:\salt\salt-call.bat"
          )
          $cmd = $paths |
            Where-Object { Test-Path $_ } |
            Select-Object -First 1
        }
        if ($cmd) {
          & $cmd --local winrepo.genrepo --out=quiet
        } else {
          throw "salt-call.exe not found"
        }
    - onchanges:
      - file: 'Manage Vs Code Winrepo Definition File'
    - shell: powershell

Ensure Local Winrepo Directory Exists:
  file.directory:
    - makedirs: True
    - name: '{{ winrepo_local_dir }}'

Manage Vs Code Winrepo Definition File:
  file.managed:
    - contents: |
        {{ pkg_name }}:
          '{{ win_version }}':
            full_name: '{{ full_name }}'
            install_flags: '/VERYSILENT /NORESTART /MERGETASKS="!runcode"'
            installer: '{{ vscode_download_uri }}'
            msiexec: false
            uninstall_flags: '/VERYSILENT /NORESTART'
    - makedirs: True
    - name: '{{ winrepo_file }}'
    - require:
      - file: 'Ensure Local Winrepo Directory Exists'

Refresh Minion Package Manager Database Cache:
  module.run:
    - name: pkg.refresh_db
    - onchanges:
      - cmd: 'Compile Local Winrepo Database'

{%- endif %}
