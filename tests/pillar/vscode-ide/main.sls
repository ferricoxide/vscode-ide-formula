vscode-ide:
  lookup:
    {%- if grains.os_family == "RedHat" %}
    config:
      /etc/vscode-ide.conf:
        extensions.autoCheckUpdates: true
        extensions.autoUpdate: true
        telemetry.telemetryLevel: "on"
        update.mode: "none"
    pkg:
      repo:
        baseurl: https://packages.microsoft.com/yumrepos/vscode
        enabled: 1
        gpgcheck: 1
        gpgkey: https://packages.microsoft.com/keys/microsoft.asc
        name: vscode-public
        summary: (Public) Visual Studio Code
    {%- elif grains.os_family == "Windows" %}
    {%- endif %}
