# Installer et configurer jupyter lab sur le raspberry
## Installation manuelle
```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python3-pip
sudo pip3 install jupyterlab
jupyter notebook --generate-config
jupyter notebook password
```
Editer le fichier de configuration avec `nano .jupyter/jupyter_notebook_config.py`
puis ajouter ou modifier les lignes suivantes :
```
c.NotebookApp.allow_origin = '*'
c.NotebookApp.ip = '0.0.0.0'
```
Créer le dossier des Notebooks avec `mkdir /home/pi/Notebooks`

Créer le script de démarrage avec `sudo nano /etc/systemd/system/jupyter.service`

Coller dans ce fichier le texte suivant :
```
[Unit]
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
WantedBy=multi-user.target
```
Lancer le serveur avec `sudo systemctl start jupyter`
Contrôler le statut du serveur avec `sudo systemctl status jupyter`
Activer définitivement le serveur avec `systemctl enable jupyter`

## Installation automatique
Copier et coller les cinq lignes suivantes dans un terminal :
```
cd
sudo apt-get install git
clone https://github.com/Lapin-Blanc/raspberry.git
cd raspberry/
./install_jupyter.sh
```
