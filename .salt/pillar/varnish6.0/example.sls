varnish:
  ## Override lookup of map.jinja
  #lookup:
  #  pkg: varnish
  #  service: varnish
  #  config_file: '/etc/default/varnish'
  #  vcl_file: '/etc/varnish/default.vcl'

  ## Specify the version here
  # version: 4.0

  ## If a version >= 5.0 is desired, you should specify the actual URL
  ## since there is no APT repository for Varnish 5.0+ at this time
  #pkg_url: http://repo.varnish-cache.org/pkg/5.0.0/varnish_5.0.0-1_amd64.deb

  ## Override the config templates to use.
  ## The pillar content will be available for processing
  #config_files:
  #  config: 'salt://varnish/templates/config.jinja'
  #  vcl: 'salt://varnish/templates/default.vcl.jinja'
