{%- from "lldp/map.jinja" import client with context -%}
{%- if client.enabled %}
{%- if grains.virtual == "physical" %}
{%- if grains.os_family == "Debian" %}

lldp_packages:
  pkg.installed:
  - name: lldpd

{{ client.configpath }}:
  file.managed:
  - source: salt://lldp/files/{{ client.configfile }}
  - template: jinja
  - require:
    - pkg: lldp_packages
lldp_service:
  service.running:
  - enable: true
  - name: {{ client.service }}
  - watch:
    - file: {{ client.configpath }}

{%- endif %}
{%- endif %}
{%- endif %}
