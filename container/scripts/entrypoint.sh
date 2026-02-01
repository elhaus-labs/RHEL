#!/bin/sh
set -eu


start_sshd_if_needed() {
  pid_file=/run/sshd.pid
  if [ -f "$pid_file" ]; then
    pid=$(cat "$pid_file" 2>/dev/null || true)
    if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
      return 0
    fi
  fi
  mkdir -p /run/sshd
  chmod 0755 /run/sshd
  /usr/sbin/sshd || true
}

start_sshd_if_needed

exec "$@"
