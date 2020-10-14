# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  id = "ubuntu-18-04"
  config.vm.box = "bento/ubuntu-18.04"
  config.vm.hostname = "zenn-vagrant"
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a forwarded port mapping which allows access to a specific port
  config.vm.network "forwarded_port", guest: 8000, host: 8000, host_ip: "127.0.0.1"

  # Share an additional folder to the guest VM.
  config.vm.synced_folder "../zenn-vagrant", "/home/vagrant/zenn-vagrant",
                            create: true, owner: 'vagrant', group: 'vagrant', fsnotify: false

  config.vm.synced_folder "./shared_folder", "/home/vagrant/shared_folder",
                            create: true, owner: 'vagrant', group: 'vagrant', fsnotify: true

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus   = 1
    # Vagrant: Slow internet connection in guest
    # https://serverfault.com/questions/495914/vagrant-slow-internet-connection-in-guest
    v.customize ["modifyvm", :id,
      "--clipboard", "bidirectional", # Share Clipboard
      "--draganddrop", "bidirectional", # Enable Drag & Drop
      "--natdnshostresolver1", "on"
    ]

    # https://stackoverflow.com/questions/19490652/how-to-sync-time-on-host-wake-up-within-virtualbox
    v.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000 ]
  end

  # Play ansible
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook       = "./ansible/all.yml"
    ansible.limit          = "localhost"
    ansible.inventory_path = "./ansible/inventories/hosts"
  end

  # Run Bootsrtap
  config.vm.provision "shell", path: "bootstrap.sh"
end
