
include:
{% if pillar.lldp.client is defined %}
- lldp.client
{% endif %}
