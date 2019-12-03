#!/bin/bash

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install python3-pip
sudo pip3 install jupyterlab
jupyter notebook --generate-config
jupyter notebook password
echo "c.NotebookApp.allow_origin = '*'" > /home/pi/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '0.0.0.0'" > /home/pi/.jupyter/jupyter_notebook_config.py
mkdir /home/pi/Notebooks
sudo echo "[Unit]
Description=Jupyter Notebook

[Service]
Type=simple
PIDFile=/run/jupyter.pid
ExecStart=/usr/local/bin/jupyter-lab --config=/home/pi/.jupyter/jupyter_notebook_config.py
User=pi
Group=pi
WorkingDirectory=/home/pi/Notebooks/
Restart=always
RestartSec=10
#KillMode=mixed

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/jupyter.service

sudo systemctl start jupyter
systemctl enable jupyter
sudo systemctl status jupyter
