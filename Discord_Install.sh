#! /bin/sh

# Vérification de l'utilisateur root
if [ "$(id -u)" -ne 0 ]; then
    echo "Ce script doit être exécuté en tant que root."
    exit 1
fi

# Remove old Discord installation
rm -rf /opt/discord /usr/bin/discord /usr/share/applications/discord.desktop /usr/share/discord /usr/share/icons/discord.png /home/$(logname)/.discord

# Variables d'installation dans le répertoire de l'utilisateur
USER_NAME=$(logname)
DISCORD_INSTALL_DIR="/home/$USER_NAME/.discord"

mkdir -p $DISCORD_INSTALL_DIR
# Download Discord
wget -O /tmp/discord.tar.gz "https://discord.com/api/download?platform=linux&format=tar.gz"

# Extract Discord
tar -xvf /tmp/discord.tar.gz
cd Discord
cp -r . $DISCORD_INSTALL_DIR
rm -rf /tmp/discord.tar.gz Discord

# Download Discord icon
wget -O $DISCORD_INSTALL_DIR/discord.png "https://cdn.icon-icons.com/icons2/3053/PNG/512/discord_macos_bigsur_icon_190238.png"

# Create symbolic link
ln -s $DISCORD_INSTALL_DIR/Discord /usr/bin/discord

# Set permissions
chown -R $USER_NAME:$USER_NAME $DISCORD_INSTALL_DIR
chmod -R 755 $DISCORD_INSTALL_DIR

# Create application shortcut
echo "[Desktop Entry]
Name=Discord
Comment=All-in-one voice and text chat for gamers that's free, secure, and works on both your desktop and phone.
Exec=$DISCORD_INSTALL_DIR/Discord
Terminal=false
Type=Application
Icon=$DISCORD_INSTALL_DIR/discord.png
Categories=Network;InstantMessaging;" > /home/$USER_NAME/.local/share/applications/discord.desktop

echo "Discord a été installé avec succès."
