# Ansible role for BOSH and CF "jump box"

![travis.ci status](https://travis-ci.org/allomov/ansible-role-bosh-jumpbox.svg)

### Description

["Jump box"](https://bosh.io/docs/terminology.html#jumpbox) is referred to as a VM that acts as a single access point for the BOSH Director and deployed VMs. Often this VM contains all necessary softaware to access BOSH and CF. This Role tends to ease configuration of resulting configuration of "jump box".

Resulting machine contains all needed software to manage BOSH and CF. This proejct serves the same goals as [jumpbox-boshrelease](https://github.com/cloudfoundry-community/jumpbox-boshrelease), but instead of `bosh-init` it uses Ansible as a deployment tool. Using `bosh-init` is fine too, still there are some limitations:

1. managing and customization of Ansible project is much more easier;
1. you don't need recreate an instance after configuration updating;
1. Ansible makes it possible to run this scripts on a PaaS of your choice, which is useful for development purposes;
1. Ansible project is easier to test

### Requirements

Install Ansible `1.9.x`, you can use [this](http://docs.ansible.com/ansible/intro_installation.html) instruction or install ansible using `pip` (the following example installs Ansible to fresh Ubuntu):
```
sudo apt-get update
sudo apt-get install python-pip python-dev -y
sudo pip install ansible
```

### How to use

You will need to install the role, create 2 files and run one command:

```bash
JUMPBOX_IP=...

ansible-galaxy install allomov.bosh-jumpbox

cat <<EOF > playbook.yml
---
- hosts: jumpbox
  sudo: yes
  roles: 
  - role: allomov.bosh-jumpbox
EOF

cat <<EOF > hosts
[jumpbox]
$JUMPBOX_IP ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_ssh_user=ubuntu
EOF

ansible-playbook -i hosts playbook.yml
```

Enjoy!
