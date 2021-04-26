#
# install k0s and required packages
#
{% from 'kzero/map.jinja' import config with context %}

kzero_install_pkgs:
  pkg.installed:
  - pkgs:
    - curl
    - jq
    # - kubectl

k0s:
  user.present:
    - home: {{ config.home }}
    - fullname: 'k0s cluster user'
    - groups:
      - sudo
    - system: true


{{ config.home }}/.k0s:
  file.directory:
    - user: k0s
    - group: k0s
    - dir_mode: 755
    - file_mode: 755

# install k0s
kzero_get_k0s:
    cmd.run:
    - name: 'curl -sSLf https://get.k0s.sh | sh'
    - require:
      - file: {{ config.home }}/.k0s
    - unless:
      - file: /usr/bin/k0s

kzero_get_kubectl:
    cmd.run:
    - name: 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/{{ grains.kernel | lower }}/{{ grains.osarch | lower }}/kubectl";chmod +x ./kubectl;mv ./kubectl /usr/local/bin/kubectl'

kzero_install_k0s:
    cmd.run:
    - name: '/usr/bin/k0s install -c {{ config.home }}/.k0s/k0s.yaml'
    - require:
      - kzero_get_k0s
