#!/bin/bash
project_dir=~/dev/aml-monorepo  # replace with your actual project directory
session_name=aml-monorepo  # keep this as the directory name

sudo systemctl start docker.service
sudo systemctl start tailscaled.service

sudo tailscale up --accept-routes
cd $project_dir && sudo docker-compose up -d
cd ~

# Start new detached session
tmux new-session -d -s $session_name -n 'vim' -c $project_dir 'nvim'

# Main run tab for server and report-generator
tmux new-window -t $session_name:2 -n 'main' -c $project_dir 'pnpm run start server --port 9230'
tmux split-window -t $session_name:2 -h -c $project_dir 'pnpm run start report-generator --port 9231'
tmux split-window -t $session_name:2 -h -c $project_dir 'pnpm run start labeler --port 9232'

# Second run tab for secondary services
tmux new-window -t $session_name:3 -n 'secondary' -c $project_dir 'pnpm run start importer'
tmux split-window -t $session_name:3 -h -c $project_dir 'pnpm run start address-validator'
tmux split-window -t $session_name:3 -h -c $project_dir 'pnpm run start client'

# Helpers tab for background processes
tmux new-window -t $session_name:4 -n 'helpers' -c $project_dir './cloud-sql-proxy --psc --auto-iam-authn prices-shared-01b5:europe-west1:shared-prices-ed60c91b --port 5433'
tmux split-window -t $session_name:4 -h -c $project_dir 'google-chrome-stable --headless --remote-debugging-port=9222'

# Attach to the session
tmux attach -t $session_name:1

