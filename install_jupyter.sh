#!/bin/bash
# Toutes le commandes qui commencent par sudo s'exécutent en tant qu'administrateur

# Consulte la liste des mises à jour disponibles
sudo apt-get -y update

# Effectue les mises à jour
sudo apt-get -y upgrade

# Installe le gestionnaire de modules python
sudo apt-get -y install python3-pip

# Installe le serveur Jupyter Lab
sudo pip3 install jupyterlab

# Génère le fichier de configuration de base de Jupyter Lab
jupyter notebook --generate-config

# Configure le mot de passe pour accéder au site
echo "****************************************************"
echo "Veuillez entrer un mot de passe pour accéder au site"
echo "****************************************************"
jupyter notebook password

# Configure le fichier de configuration pour que n'importe quelle machine sur le réseau puisse se connecter
echo "c.NotebookApp.allow_origin = '*'" >> /home/pi/.jupyter/jupyter_notebook_config.py

# Configure le fichier de configuration pour que le serveur attende les connection sur l'adresse IP publique
echo "c.NotebookApp.ip = '0.0.0.0'" >> /home/pi/.jupyter/jupyter_notebook_config.py

# Crée le dossier où seront enregistrés les notebooks
mkdir /home/pi/Notebooks

# Crée un script de démarrage (service) pour pouvoir lancer automatiquement le script au démarrage du système
echo "[Unit]
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
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/jupyter.service

# Lance manuellement le service
sudo systemctl start jupyter

# Active le lancement automatique du service au démarrage du système
sudo systemctl enable jupyter

# Vérifie l'état du service
sudo systemctl status jupyter
