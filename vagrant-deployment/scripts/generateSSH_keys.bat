mkdir vagrantkeys

if exist vagrantkeys/vagrant_rsa (
    echo "Keys found.."
) else (
    echo "Keys not found.."
    ssh-keygen -f "vagrantkeys/vagrant_rsa" -q -N ""
)

