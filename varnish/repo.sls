# Configure the official varnish repo
{% from "varnish/map.jinja" import varnish as varnish_map with context %}
{%- set config = salt['pillar.get']('varnish', {}) %}
{%- set oscodename = salt['grains.get']('oscodename') %}
{%- set varnish_version = config.get('version', '4.0') %}
{%- set repo_component = 'varnish' ~ varnish_version|replace('.','') %}

varnish_repo:
  pkgrepo.managed:
    - name: deb https://packagecloud.io/varnishcache/{{ repo_component }}/{{ salt['grains.get']('os')|lower }}/ {{ oscodename }} main
    - key_url: https://packagecloud.io/varnishcache/{{ repo_component }}/gpgkey
    - file: /etc/apt/sources.list.d/varnish.list
    - clean_file: True
    - require_in:
      - pkg: {{ varnish_map.pkg }}
