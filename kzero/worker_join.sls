# show worker info
{% from 'kzero/map.jinja' import config with context %}

{% if config.get('worker', {}).get('master_fqdn', None) and config.get('worker', {}).get('token', None) %}
/etc/systemd/system/k0s.service:
  file.managed:
  - source:
    - salt://kzero/files/k0s-worker.service.jinja2
  - template: jinja
  - replace: True
  - context:
      config: {{ config.worker }}

kzero_start_k0s_worker:
  service.running:
  - name: k0s
  - restart: True
  - enable: True
{% endif %}