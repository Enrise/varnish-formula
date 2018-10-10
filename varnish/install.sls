# Install Varnish Package from the repo
{% from "varnish/map.jinja" import varnish as varnish_map with context %}
{%- set config = salt['pillar.get']('varnish', {}) %}

include:
  - .repo

{{ varnish_map.pkg }}:
  pkg.installed:
    - require:
      - pkgrepo: varnish_repo
