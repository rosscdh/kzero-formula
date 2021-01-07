#
# start k0s and required packages
#
{% from 'kzero/map.jinja' import config with context %}

kzero_start_k0s:
  service.running:
  - name: k0s
  - reload: True
  - enable: True