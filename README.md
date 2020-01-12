# nomadgrant

boot nomad with multiple Linux distributions.

# Usage

## build nomad binary (for alpine linux)

- cd build-nomad
- sh build.sh

## up

- vagrant up

## check

- consul webui: http://localhost:8500
- nomad webui: http://localhost:4646
- CLI
  - consul members
  - nomad server members
  - nomad node status
  - nomad status

## run containers

- nomad run [examples/example.nomad](./examples/example.nomad)

## resolve with consul DNS

service can be resolved by service name (job.group.service.name)

- vagrant ssh nomad1
  - host myredis

# settings

![](nomad1_0.svg)

you can customize some settings. modify [ansible.groups](./Vagrantfile#L58)

- nomad-server run on consul-server node
  - containers will not run on consul/nomad server node if you does not install docker
- container's IP address can be resolved by service name using dnsmasq + consul
- exec-driver, java-driver can be used on some nomad client node (nomad-server run as root user)

![default settings](nomad1_1.svg)
