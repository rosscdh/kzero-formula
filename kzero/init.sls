{% from 'kzero/map.jinja' import config with context %}
#
# if your pi errors out with no space errors
# its probably this https://medium.com/better-programming/create-a-multi-architecture-k0s-cluster-e265d24937b3
# needing to recompile with cgroups flags
#
include:
- kzero.install