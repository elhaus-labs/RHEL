$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$compose = Join-Path $root "container\\docker-compose.yml"

Write-Host "Building image..."
docker compose -f $compose build

Write-Host "Starting container..."
docker compose -f $compose up -d

Write-Host "Done."
