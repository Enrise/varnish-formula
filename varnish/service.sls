{% from "varnish/map.jinja" import varnish as varnish_map with context %}

# Extend varnish to include a service, and ensure its always running
extend:
  {{ varnish_map.service }}:
    service.running:
      - enable: True
      - reload: True
      - require:
        - pkg: {{ varnish_map.pkg }}
