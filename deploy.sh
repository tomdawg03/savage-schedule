#!/bin/bash

# Update system packages
sudo apt-get update
sudo apt-get upgrade -y

# Install Python and pip if not already installed
sudo apt-get install -y python3 python3-pip python3-venv nginx

# Install PostgreSQL
sudo apt-get install -y postgresql postgresql-contrib

# Create a Python virtual environment
python3 -m venv venv
source venv/bin/activate

# Install Python dependencies
pip install -r requirements.txt

# Create .env file from example if it doesn't exist
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cp .env.example .env
    echo "Please update the .env file with your actual credentials"
fi

# Set up Nginx configuration
sudo bash -c 'cat > /etc/nginx/sites-available/savage-schedule << EOL
server {
    listen 80;
    server_name _;  # Replace with your domain name when you have one

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }

    location /api {
        proxy_pass http://127.0.0.1:5001;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOL'

# Enable the Nginx site
sudo ln -sf /etc/nginx/sites-available/savage-schedule /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo systemctl restart nginx

# Create systemd service for frontend
sudo bash -c 'cat > /etc/systemd/system/savage-frontend.service << EOL
[Unit]
Description=Savage Schedule Frontend
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/savage-schedule
Environment="PATH=/home/ubuntu/savage-schedule/venv/bin"
ExecStart=/home/ubuntu/savage-schedule/venv/bin/python frontend/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOL'

# Create systemd service for backend
sudo bash -c 'cat > /etc/systemd/system/savage-backend.service << EOL
[Unit]
Description=Savage Schedule Backend
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/savage-schedule
Environment="PATH=/home/ubuntu/savage-schedule/venv/bin"
ExecStart=/home/ubuntu/savage-schedule/venv/bin/python backend/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOL'

# Start and enable the services
sudo systemctl daemon-reload
sudo systemctl enable savage-frontend savage-backend
sudo systemctl start savage-frontend savage-backend

echo "Deployment script completed. Please check the services are running:"
echo "sudo systemctl status savage-frontend"
echo "sudo systemctl status savage-backend" 