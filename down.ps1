$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$compose = Join-Path $root "container\\docker-compose.yml"

Write-Host "Stopping and removing container..."
docker compose -f $compose down --rmi local --volumes --remove-orphans

Write-Host "Skipping global build cache prune to keep base images locally cached."

Write-Host "Cleaning SSH known_hosts entries..."
$knownHosts = Join-Path $env:USERPROFILE ".ssh\\known_hosts"
if (Test-Path $knownHosts) {
  ssh-keygen -R "[127.0.0.1]:2222" -f $knownHosts | Out-Null
}

Write-Host "Done."
