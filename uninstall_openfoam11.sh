#!/bin/bash

set -e

echo "Purgando OpenFOAM 11 y paquetes relacionados..."
sudo apt purge -y openfoam11
sudo apt autoremove --purge -y

echo "Eliminando claves GPG relacionadas con OpenFOAM..."
sudo rm -f /etc/apt/trusted.gpg.d/openfoam.gpg
sudo rm -f /etc/apt/trusted.gpg.d/openfoam.asc

echo "Eliminando repositorios OpenFOAM de sources.list y sources.list.d..."
sudo sed -i '/openfoam/d' /etc/apt/sources.list
sudo rm -f /etc/apt/sources.list.d/*openfoam*

echo "Actualizando lista de paquetes..."
sudo apt update

echo "Eliminando línea de configuración OpenFOAM en ~/.bashrc..."
sed -i '/\/opt\/openfoam11\/etc\/bashrc/d' ~/.bashrc

echo "Recargando ~/.bashrc para limpiar variables de entorno actuales..."
source ~/.bashrc

echo "Verificando que OpenFOAM esté desinstalado..."

if command -v foamVersion >/dev/null 2>&1; then
  echo "ERROR: foamVersion sigue disponible."
else
  echo "foamVersion no está disponible, OK."
fi

if [ -z "$WM_PROJECT_DIR" ]; then
  echo "Variable WM_PROJECT_DIR no está definida, OK."
else
  echo "ERROR: Variable WM_PROJECT_DIR sigue definida en: $WM_PROJECT_DIR"
fi

echo "Proceso de desinstalación completado."
