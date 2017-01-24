# Install Varnish Package from the repo
{% from "varnish/map.jinja" import varnish as varnish_map with context %}
{%- set config = salt['pillar.get']('varnish', {}) %}
{%- set varnish_version = config.get('version', '4.0') %}

{%- if varnish_version|float() < 5.0 %}
include:
  - .repo
{%- endif %}

{{ varnish_map.pkg }}:
  pkg.installed:
{%- if varnish_version|float() < 5.0 %}
    - require:
      - pkgrepo: varnish_repo
{%- else %}
    - sources:
      - varnish: {{ config.get('pkg_url', 'http://repo.varnish-cache.org/pkg/5.0.0/varnish_5.0.0-1_amd64.deb') }}
    - unless: dpkg -l | grep '^ii   varnish' # prevent auto upgrades
{%- endif %}
