# dev-machine

This is my personal [Ansible](https://www.ansible.com/) provisioned development machine configuration. It is very much tailored for my needs. Feel free to use, but use it at your own risk.

Tested on _macOS 10.12.x_.

## Getting started

By running the line below, you'll start bootstrapping my development machine on your local machine.

```bash
bash <(curl -s https://raw.githubusercontent.com/eriktoyra/dev-machine/master/bootstrap.sh)
```

Install Ansible roles not present in this repo.

```bash
ansible-galaxy install -r requirements.yml
```

Configure `./vars/` config files and then run:

```bash
ansible-playbook playbook.yml
```

## Development

To check the syntax of the `playbook.yml` file, run
`ansible-playbook playbook.yml --syntax-check`.
