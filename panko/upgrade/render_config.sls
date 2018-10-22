{%- from "panko/map.jinja" import server with context %}

panko_render_config:
  test.show_notification:
    - text: "Running panko.upgrade.render_config"

{%- if server.enabled %}
/etc/panko/panko.conf:
  file.managed:
  - source: salt://panko/files/{{ server.version }}/panko.conf.{{ grains.os_family }}
  - template: jinja
{%- endif %}
