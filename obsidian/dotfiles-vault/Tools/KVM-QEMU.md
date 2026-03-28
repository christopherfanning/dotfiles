# KVM / QEMU / Virt-Manager

> Native Linux virtualization stack. Best performance for Linux VMs — no hypervisor overhead.

## Stack

| Component | Role |
|-----------|------|
| **KVM** | Kernel module — hardware virtualisation |
| **QEMU** | Machine emulator that uses KVM |
| **libvirt** | Management API layer (used by virt-manager, vagrant, etc.) |
| **virt-manager** | GUI for creating and managing VMs |

## Post-install (done by arch-install.sh)

```bash
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
# Log out and back in for group membership to take effect
```

## Create a VM

1. Launch `virt-manager`
2. New VM → select ISO or existing image
3. Set CPU/RAM/disk to match your target (e.g. Lightsail `micro_3_0` = 1 vCPU, 1GB RAM)

## Quick CLI (virsh)

```bash
virsh list --all           # list all VMs
virsh start my-vm          # start a VM
virsh shutdown my-vm       # graceful stop
virsh snapshot-create-as my-vm snap1   # snapshot
```

## Notes

- Use **Multipass** for quick disposable Ubuntu VMs — virt-manager is better for longer-lived VMs needing custom networking/storage
- VirtualBox can be added later for Windows VMs — coexists fine with KVM
