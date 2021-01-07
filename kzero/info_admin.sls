#
# Show info for cluster
#
{% from 'kzero/map.jinja' import config with context %}

kzero_show_admin_info:
  cmd.run:
  - name: '/usr/bin/k0s kubeconfig admin -c {{ config.home }}/.k0s/k0s.yaml'
