mkdir vagrantkeys

if [ -f vagrantkeys/vagrant_rsa ];
then
    echo "Keys found.."
else
    echo "Keys not found.."
    ssh-keygen -f "vagrantkeys/vagrant_rsa" -q -N ""
fi