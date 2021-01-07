#
# join a new controller
#
{% from 'kzero/map.jinja' import config with context %}
kzero_worker_join_cluster:
  cmd.run:
  - name: '/usr/bin/k0s controller -c {{ config.home }}/.k0s/k0s.yaml "{{ config.controller.token }}"'
  - require:
    - /usr/bin/k0s