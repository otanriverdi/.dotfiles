#!/bin/bash
project_dir=~/dev/aml-monorepo  # replace with your actual project directory
session_name=cense-db  # keep this as the directory name

sudo systemctl start tailscaled.service

sudo tailscale up --accept-routes
# Start new detached session
tmux new-session -d -s $session_name -n 'staging:5434-prod:5435' -c $project_dir './cloud-sql-proxy trust-report-staging-987a:europe-west1:trust-report-staging-data-0b4f9c1c --port 5434 --private-ip'
tmux split-window -t $session_name:1 -h -c $project_dir './cloud-sql-proxy --private-ip --auto-iam-authn trust-report-production-7db9:europe-west1:trust-report-prod-data-44502a9e --port 5435'

# Attach to the session
tmux attach -t $session_name:1

