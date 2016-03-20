echo "updating..."
sudo apt-get update
echo "installing needed packages"
sudo apt-get install -y python-pip python-crypto python-dev rabbitmq-server sshpass python-mysqldb supervisor
sudo pip install -r /vagrant/eisen_engine/requirements.txt
echo "adding localhost to /etc/ansible/hosts"
mkdir -p /etc/ansible/group_vars/
echo -e "[vagrant]\nlocalhost" > /etc/ansible/hosts
echo -e "ansible_ssh_user: vagrant\nansible_ssh_pass: vagrant" > /etc/ansible/group_vars/vagrant
echo "adding StrictHostKeyChecking no to .ssh/config"
echo -e "Host *\n StrictHostKeyChecking no" > /home/vagrant/.ssh/config
chown vagrant:vagrant /home/vagrant/.ssh/config
mkdir /root/.ssh/
sudo touch /root/.ssh/config
sudo echo -e "Host *\n StrictHostKeyChecking no" > /root/.ssh/config
echo "setting init"
cp /vagrant/eisen_engine/init/eisen-* /etc/init.d/
chmod +x /etc/init.d/eisen-*
echo "start init"
service eisen-engine start
service eisen-celery start
