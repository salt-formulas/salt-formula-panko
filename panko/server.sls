{%- from "panko/map.jinja" import server with context %}
{%- if server.get('enabled', False) %}

panko_server_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

/etc/panko/panko.conf:
  file.managed:
  - source: salt://panko/files/{{ server.version }}/panko.conf.{{ grains.os_family }}
  - template: jinja
  - require:
    - pkg: panko_server_packages

{%- if not grains.get('noservices', False) %}
panko_syncdb:
  cmd.run:
  - name: panko-dbsync
  - require:
    - file: /etc/panko/panko.conf
{%- endif %}

/etc/apache2/sites-available/panko-api.conf:
  file.managed:
  - source: salt://panko/files/{{ server.version }}/panko-api.apache2.conf.Debian
  - template: jinja
  - require:
    - pkg: panko_server_packages

panko_api_config:
  file.symlink:
  - name: /etc/apache2/sites-enabled/panko-api.conf
  - target: /etc/apache2/sites-available/panko-api.conf

panko_apache_restart:
  service.running:
  - enable: true
  - name: apache2
  - watch:
    - file: /etc/panko/panko.conf
    - file: /etc/apache2/sites-available/panko-api.conf

{%- endif %}
