sudo useradd -G video jantest
sudo usermod -aG optical jantest

sudo bash -c "echo 'jantest ALL=(root) /usr/bin/ip' >> /etc/sudoers"

sudo groupadd projekt
sudo usermod -aG projekt asgavar
sudo usermod -aG projekt jantest

sudo bash -c "echo 'jantest ALL=(asgavar) /usr/bin/whoami'"
su jantest
sudo -u asgavar whoami

# zmienić CHFN_RESTRICT w /etc/login.def
su jantest
chfn -f 'Jan Kowalski'
finger
pinky
