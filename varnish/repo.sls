# Configure the official varnish repo
{% from "varnish/map.jinja" import varnish as varnish_map with context %}
{%- set config = salt['pillar.get']('varnish', {}) %}
{%- set oscodename = salt['grains.get']('oscodename') %}
{%- set varnish_version = config.get('version', '4.0') %}
{%- set repo_component = 'varnish-' ~ varnish_version %}

# @todo support for Varnish 5.0, no repo yet as of 24-01-2017.

# Deal with oscodename downgrade for xenial
{%- if oscodename == 'xenial' %}
# Varnish offers no Xenial packages for Varnish < 5.0 therefor we'll be using the trusty packages instead.
# See https://www.varnish-cache.org/lists/pipermail/varnish-misc/2016-May/024943.html
{%- set oscodename = 'trusty' %}
{%- endif %}

varnish_repo:
  pkgrepo.managed:
    - name: deb http://repo.varnish-cache.org/{{ salt['grains.get']('os')|lower }}/ {{ oscodename }} {{ repo_component }}
    - file: /etc/apt/sources.list.d/varnish.list
    - keyid: C4DEFFEB
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: {{ varnish_map.pkg }}
