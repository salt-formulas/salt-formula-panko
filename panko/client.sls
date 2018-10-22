{%- from "panko/map.jinja" import client with context %}
{%- if client.enabled %}

panko_client_packages:
  pkg.installed:
  - names: {{ client.pkgs }}

{%- endif %}