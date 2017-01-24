# Manage core configuration for Varnish
{% from "varnish/map.jinja" import varnish as varnish_map with context %}
{%- set config = salt['pillar.get']('varnish', {}) %}

# Instal the Varnish config
{{ varnish_map.config_file }}:
  file.managed:
    - source: {{ config.get('config_files:config', 'salt://varnish/files/config') }}
    - template: jinja
    - watch_in:
      - service: {{ varnish_map.service }}

# Install the VCL file
{{ varnish_map.vcl_file }}:
  file.managed:
    - source: {{ config.get('config_files:vcl', 'salt://varnish/files/default.vcl') }}
    - template: jinja
    - require_in:
      - file: {{ varnish_map.config_file }}
    - watch_in:
      - service: {{ varnish_map.service }}
