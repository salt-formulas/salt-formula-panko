{%- from "panko/map.jinja" import server with context %}

include:
 - panko.upgrade.service_stopped
 - panko.upgrade.pkgs_latest
 - panko.upgrade.render_config
 - panko.db.offline_sync
 - panko.upgrade.service_running
