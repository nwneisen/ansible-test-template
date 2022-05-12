# Ansible Template

This project is setup as an Ansible template for testing Ansible scripts. The project uses a docker image to test an installation against for easy resetting after running. After adding Ansible playbooks and testing, you may choose to run the playbooks on your local or remote (future) machines.

## Quick Start

Before starting the container must be built
`make build`

Current a the container must be connected to before SSH works with Ansible
`make connect`

Afterwards, the default make command with test playbooks with the docker container
`make`

If you are happy with the playbook(s), you may run Ansible on your local system
`make install`
