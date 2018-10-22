{%- from "panko/map.jinja" import server,upgrade with context %}

panko_task_service_stopped:
  test.show_notification:
    - text: "Running panko.upgrade.service_stopped"

{%- if server.enabled %}
panko_service_stopped_{{ server.service_name }}:
  service.dead:
  - name: {{ server.service_name }}
  - enable: False
{%- endif %}
