{%- from "panko/map.jinja" import server with context %}

panko_syncdb:
  cmd.run:
  - name: panko-dbsync
  {%- if grains.get('noservices') or server.get('role', 'primary') == 'secondary' %}
  - onlyif: /bin/false
  {%- endif %}
