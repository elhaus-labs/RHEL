# RHEL Base Image

Minimal RHEL (UBI9) container image with:
- `lab` user and `root` credentials set
- SSH server enabled

## Start/Stop

```powershell
./up.ps1
```

```powershell
./down.ps1
```

## SSH Access

Default credentials:
- User: `lab` / Password: `lab`
- Root: `root` / Password: `root`

Port mapping:
- `rhel-base`: `127.0.0.1:2222`

Examples:
```bash
ssh lab@127.0.0.1 -p 2222
ssh root@127.0.0.1 -p 2222
```

## Build/Run Without Compose

```bash
docker build -f container/Dockerfile -t rhel-base:local container
docker run --privileged --tmpfs /run --tmpfs /run/lock \
  -p 2222:22 \
  -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
  rhel-base:local
```

## GHCR Publishing

The workflow in `.github/workflows/publish-ghcr.yml` builds the image from `container/Dockerfile`
and pushes `ghcr.io/<owner>/<repo>:latest` plus a SHA tag on every push to `main`.
