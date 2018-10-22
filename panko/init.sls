
include:
{%- if pillar.panko.server is defined %}
- panko.server
{%- endif %}
{%- if pillar.panko.client is defined %}
- panko.client
{%- endif %}
