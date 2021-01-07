# show worker info
{% from 'kzero/map.jinja' import config with context %}

{% if config.get('worker', {}).get('token', None) %}
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
  - reload: True
  - enable: True
  - onchange:
    - file: /etc/systemd/system/k0s.service
{% else %}
'echo "You must define a worker.token for this minion"':
  cmd.run
{% endif %}