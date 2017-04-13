{%- from "lldp/map.jinja" import client with context -%}
{%- if client.enabled %}
{%- if grains.virtual == "physical" %}
{%- if grains.os_family == "Debian" %}

lldp_packages:
  pkg.installed:
  - name: lldpd

/etc/lldpd.d/interfaces.conf:
  file.managed:
  - source: salt://lldp/files/interfaces.conf
  - template: jinja
  - require:
    - pkg: lldp_packages

lldp_service:
  service.running:
  - enable: true
  - name: {{ client.service }}
  - watch:
    - file: /etc/lldpd.d/interfaces.conf


{%- endif %}
{%- endif %}
{%- endif %}
