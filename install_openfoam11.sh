#!/bin/bash

# Script para instalar OpenFOAM 11 en Ubuntu 24.04 "Noble"
# Installation script for OpenFOAM 11 on Ubuntu 24.04 "Noble"

set -e  # Terminar el script si algún comando falla
# Exit script if any command fails

echo "🔄 Actualizando lista de paquetes..."
# Updating package list...
sudo apt update

echo "📦 Instalando dependencias necesarias..."
# Installing necessary dependencies...
sudo apt install -y software-properties-common curl

echo "🔐 Importando la clave GPG oficial de OpenFOAM..."
# Importing official OpenFOAM GPG key...
curl -fsSL https://dl.openfoam.org/gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/openfoam.gpg > /dev/null

echo "➕ Agregando el repositorio oficial de OpenFOAM para Ubuntu Noble..."
# Adding official OpenFOAM repository for Ubuntu Noble...
if ! grep -q "^deb http://dl.openfoam.org/ubuntu noble main" /etc/apt/sources.list.d/openfoam.list 2>/dev/null; then
  echo "deb http://dl.openfoam.org/ubuntu noble main" | sudo tee /etc/apt/sources.list.d/openfoam.list
fi

echo "🔁 Actualizando lista de paquetes nuevamente con el repositorio de OpenFOAM..."
# Updating package list again with OpenFOAM repo...
sudo apt update

echo "📥 Instalando OpenFOAM 11..."
# Installing OpenFOAM 11...
sudo apt install -y openfoam11

echo "⚙️ Configurando el entorno para cargar OpenFOAM automáticamente al iniciar sesión..."
# Configuring environment to load OpenFOAM automatically on login...
if ! grep -q "/opt/openfoam11/etc/bashrc" ~/.bashrc; then
  echo "source /opt/openfoam11/etc/bashrc" >> ~/.bashrc
fi

# Cargando la configuración de OpenFOAM solo si la sesión es interactiva
if [[ $- == *i* ]]; then
  echo "📂 Cargando la configuración de OpenFOAM en esta sesión interactiva..."
  source /opt/openfoam11/etc/bashrc
else
  echo "ℹ️ Sesión no interactiva: omitiendo 'source' para evitar errores de entorno (CI/CD seguro)"
fi

echo "✅ Instalación y configuración de OpenFOAM 11 completada con éxito."
# OpenFOAM 11 installation and configuration completed successfully.

