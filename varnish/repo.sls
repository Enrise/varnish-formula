# Configure the official varnish repo
{% from "varnish/map.jinja" import varnish as varnish_map with context %}
{%- set config = salt['pillar.get']('varnish', {}) %}
{%- set lsb_codename = salt['grains.get']('lsb_distrib_codename') %}
{%- set repo_component = 'varnish-4.0' %}

# Install Varnish repository
{%- if 'version' in config and config.version|float() >= 5.0 %}
# Use the new repo (tbd, since there is none yet just plain files)
varnish_repo:
  test.show_notification:
    - text: 'No repo available for Varnish 5.0 and up at the moment.'
{%- else %}
varnish_repo:
  pkgrepo.managed:
    - name: deb http://repo.varnish-cache.org/{{ salt['grains.get']('os')|lower }}/ {{ salt['grains.get']('oscodename')}} {{ repo_component }}
    - file: /etc/apt/sources.list.d/varnish.list
    - keyid: C4DEFFEB
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: varnish
{%- endif %}
