# Managed by Saltstack.
# Source: {{ source }}

# This is a ultra-minimal valid VCL for Varnish that uses the default conf
# already present in the code. That means an conservative approach regarding
# cache policies (e.g. no caching of any cookie related object).

backend default {
    .host = "127.0.0.1";
    .port = "8080";
}
