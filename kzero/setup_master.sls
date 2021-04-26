#
# setup the master controller in homedir
#
{% from 'kzero/map.jinja' import config with context %}

# kzero_setup_default_config:
#     cmd.run:
#     - name: '/usr/bin/k0s default-config | tee {{ config.home }}/.k0s/k0s.yaml'

/etc/systemd/system/k0s.service:
  file.managed:
  - source:
    - salt://kzero/files/k0s.service.jinja2
  - template: jinja
  - replace: True
  - context:
      home: {{ config.home }}


kzero_update_k0s_yaml:
  file.managed:
  - name: {{ config.home }}/.k0s/k0s.yaml'
  - source: salt://kzero/files/k0s.yaml.jinja2
  - template: jinja
  - replace: True
  - context:
      config: {{ config.controller.config }}

kzero_install_k0s:
    cmd.run:
    - name: '$(which k0s) install controller -c {{ config.home }}/.k0s/k0s.yaml'

