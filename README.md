# kzero-formula

k0 formula


> See the full [Salt Formulas installation and usage instructions](http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html)

## Available States

```
kzero # runs generic install
kzero.setup_master
kzero.start_master

kzero.worker_join # provider a kzero.worker.token (that you get from the kzero.info)

kzero.controller_join # if you want HA controllers you can get the controller token from info_admin

kzero.info  # join tokens (controller and worker)
kzero.info_admin # Admin kubeconfig
```
# ***kzero***

base state

# Process

**states/base/top.sls**

```
base:
  'kpot*_master':
    - kzero
    - kzero.setup_master
    - kzero.start_master
    - kzero.info
    - kzero.info_admin

  'kpot*_worker':
    - kzero
    - kzero.worker_join
```

**pillars/base/top.sls**

```
base:
  'kpot*_master':
    - k0s_master

  'kpot*_worker':
    - k0s_worker
```

### Workflow

1. Setup the tops as above
2. The Master Controller needs no configuration for single node
3. state.apply on the master (this will take some time, and you may need to run info and info_admin seperately once the master is running)
4. state.apply on the worker
5. get the admin KUBECONFIG from info_admin and set it up locally
6. NB if your nodes complain about NotReady and image 0 in the kubectl describe node then you need to recompile the linux kernel on your pi to support crgroups as per https://medium.com/better-programming/create-a-multi-architecture-k0s-cluster-e265d24937b3 (thanks https://github.com/lucj)

# Testing
using the test suite

setup dependencies: ```make setup```

run tests: ```make tests```


# Template

This formula was created from a cookiecutter template.

> See (https://github.com/thiccbois/salt-formula-cookiecutter)
