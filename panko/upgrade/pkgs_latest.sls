{%- from "panko/map.jinja" import server,client,upgrade with context %}

panko_task_pkg_latest:
  test.show_notification:
    - text: "Running panko.upgrade.pkg_latest"

policy-rc.d_present:
  file.managed:
    - name: /usr/sbin/policy-rc.d
    - mode: 755
    - contents: |
        #!/bin/sh
        exit 101

{%- set pkgs = [] %}
{%- if server.enabled %}
  {%- do pkgs.extend(server.pkgs) %}
{%- endif %}
{%- if client.enabled %}
  {%- do pkgs.extend(client.pkgs) %}
{%- endif %}

panko_pkg_latest:
  pkg.latest:
  - names: {{ pkgs|unique }}
  - require:
    - file: policy-rc.d_present
  - require_in:
    - file: policy-rc.d_absent

policy-rc.d_absent:
  file.absent:
    - name: /usr/sbin/policy-rc.d
