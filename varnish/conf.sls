# Manage core configuration for Varnish
{% from "varnish/map.jinja" import varnish as varnish_map with context %}
{%- set config = salt['pillar.get']('varnish', {}) %}
{%- set config_files = config.get('config_files', {}) %}

# Install the Varnish config
{{ varnish_map.config_files.config }}:
  file.managed:
    - source: {{ config_files.get('config', 'salt://varnish/files/config') }}
    - template: jinja
    - watch_in:
      - service: {{ varnish_map.service }}

# Install the VCL file
{{ varnish_map.config_files.vcl }}:
  file.managed:
    - source: {{ config_files.get('vcl', 'salt://varnish/files/default.vcl') }}
    - template: jinja
    - require_in:
      - file: {{ varnish_map.config_files.config }}
    - watch_in:
      - service: {{ varnish_map.service }}
