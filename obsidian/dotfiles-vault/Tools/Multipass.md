# Multipass — Quick Ubuntu Cloud VMs

> Spin up Ubuntu VMs in seconds with a cloud-like feel. Best tool for mirroring Lightsail locally.

## Why Multipass (over virt-manager for dev)

- One command to get a running Ubuntu VM: `multipass launch`
- Supports **cloud-init** — same provisioning scripts Packer uses on AWS work here too
- VMs are disposable: easy to create, snapshot, and delete
- Feels exactly like a Lightsail instance (Ubuntu, SSH, cloud-init)

## Usage

```bash
multipass launch --name wordpress-dev --cpus 1 --memory 1G --disk 20G
multipass shell wordpress-dev        # SSH into the VM
multipass list                       # list all VMs
multipass stop wordpress-dev
multipass delete wordpress-dev && multipass purge
```

## Use with cloud-init (mirror Lightsail provisioning)

```bash
multipass launch --name test-deploy --cloud-init cloud-init.yml
```

`cloud-init.yml` example:
```yaml
#cloud-config
packages:
  - docker.io
  - docker-compose-v2
runcmd:
  - systemctl enable --now docker
  - usermod -aG docker ubuntu
```

## Workflow: local → production

1. `multipass launch` — fresh Ubuntu VM
2. Run your provisioning script / cloud-init inside it
3. Verify the app works
4. Build the same image with Packer → push to AWS as AMI
5. Deploy via OpenTofu

## Notes

- Default user inside Multipass VMs is `ubuntu`
- Multipass uses its own network bridge — VMs get IPs in `192.168.64.x` range
- Snapshots: `multipass snapshot wordpress-dev` before risky changes
