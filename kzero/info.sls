#
# Show info for cluster
#
{% from 'kzero/map.jinja' import config with context %}

kzero_show_kubeconfig:
  cmd.run:
  - name: 'cat /var/lib/k0s/pki/admin.conf'
  require:
  - file: /var/lib/k0s/pki/admin.conf


kzero_show_controller_token:
  cmd.run:
  - name: '/usr/bin/k0s token create --role=controller --expiry={{ config.controller.token_expires }}'

kzero_show_worker_token:
  cmd.run:
  - name: '/usr/bin/k0s token create --role=worker --expiry={{ config.worker.token_expires }}'
