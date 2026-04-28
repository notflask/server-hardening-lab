Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"
  config.vm.hostname = "hardening-lab"

  # Network configuration
  # We forward the custom SSH port (2222) to the host.
  # Note: Vagrant's internal SSH typically uses 2222 on host -> 22 on guest.
  # We use auto_correct to prevent collisions.
  config.vm.network "forwarded_port", guest: 2222, host: 2222, id: "ssh-hardened", auto_correct: true
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8443

  # Provisioning using Ansible
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/playbook.yml"
    ansible.inventory_path = "ansible/inventory.ini"
    ansible.limit = "all"
    ansible.compatibility_mode = "2.0"
  end

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vb.gui = false
  end

  config.vm.provider "vmware_desktop" do |v|
    v.gui = false
    v.cpus = 2
    v.memory = "2048"
  end
end
