{%- from "panko/map.jinja" import server,upgrade with context %}

panko_task_service_running:
  test.show_notification:
    - text: "Running panko.upgrade.service_running"

{%- if server.enabled %}
panko_service_running_{{ server.service_name }}:
  service.running:
  - name: {{ server.service_name }}
  - enable: True
{%- endif %}
