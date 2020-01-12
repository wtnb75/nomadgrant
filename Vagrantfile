imgs = ["ubuntu/bionic64", "ubuntu/xenial64", "centos/7", "centos/8", "generic/alpine310"]
# fedora/31-cloud-base
# generic/alpine310
# archlinux/archlinux

boxes = [
  ["consul1",  imgs[4], "192.168.3.10", 8500],
  ["consul2",  imgs[2], "192.168.3.11", 4646],
  ["consul3",  imgs[4], "192.168.3.12"],
  ["nomad1",   imgs[4], "192.168.3.20"],
  ["nomad2",   imgs[4], "192.168.3.21"],
  ["nomad3",   imgs[2], "192.168.3.22"],
  ["nomad4",   imgs[3], "192.168.3.23"],
  ["nomad5",   imgs[0], "192.168.3.24"],
]

Vagrant.configure("2") do |config|
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect=true
    config.cache.scope = :box
  end
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = ENV["http_proxy"]
    config.proxy.https    = ENV["https_proxy"]
    config.proxy.no_proxy = "localhost,127.0.0.1,192.168.0.0/16,10.0.0.0/8,172.16.0.0/12"
  end
  config.vbguest.auto_update=false
  config.vm.box_check_update=false
  boxes.each do|name,box,addr1,port|
    config.vm.define name do|cfg|
      cfg.vm.box = box
      if name.match "consul"
        cfg.vm.provider "virtualbox" do |vb|
          vb.cpus="1"
          vb.memory="512"
        end
      elsif name.match "nomad"
        cfg.vm.provider "virtualbox" do |vb|
          vb.cpus="2"
          vb.memory="2048"
        end
      end

      if addr1
        cfg.vm.network "private_network", ip: addr1, virtualbox__intnet: "internal1"
      end
      if port
        cfg.vm.network "forwarded_port", guest: port, host: port, auto_correct: true
      end
      cfg.vm.hostname = "#{name}.local"

      if box.match "alpine"
        cfg.vm.provision "shell", path: "alpine-init.sh"
      end

      cfg.vm.provision "ansible" do|ansible|
        ansible.playbook = "ansible/site.yml"
        ansible.groups = {
          "centos" => boxes.select{|e| e[1].match "centos"}.map{|e| e[0]},
          "fedora" => boxes.select{|e| e[1].match "fedora"}.map{|e| e[0]},
          "ubuntu" => boxes.select{|e| e[1].start_with? "ubuntu"}.map{|e| e[0]},
          "archlinux" => boxes.select{|e| e[1].match "archlinux"}.map{|e| e[0]},
          "alpine" => boxes.select{|e| e[1].match "alpine"}.map{|e| e[0]},
          "consul" => boxes.select{|e| e[0].match "consul"}.map{|e| e[0]},
          "nomad" => boxes.select{|e| e[0].match "nomad"}.map{|e| e[0]},
          "consul_server" => boxes.select{|e| e[0].match "consul"}.map{|e| e[0]},
          "nomad_server_only" => boxes.select{|e| e[0].match "consul"}.map{|e| e[0]},
          "consul_client" => boxes.select{|e| !e[0].match "consul"}.map{|e| e[0]},
          #"nomad_server" => boxes.select{|e| e[0].match "nomad[123]$"}.map{|e| e[0]},
          #"nomad_client" => boxes.select{|e| e[0].match "nomad[4-9]$"}.map{|e| e[0]},
          "nomad_client" => boxes.select{|e| e[0].match "nomad"}.map{|e| e[0]},
          "java" => ["nomad2","nomad4"],
        }
        if Vagrant.has_plugin?("vagrant-proxyconf")
          ansible.extra_vars = {
            proxy: {
              http_proxy: config.proxy.http,
              https_proxy: config.proxy.http,
              HTTP_PROXY: config.proxy.https,
              HTTPS_PROXY: config.proxy.https,
              no_proxy: config.proxy.no_proxy,
              NO_PROXY: config.proxy.no_proxy,
            }
          }
        end
      end
    end
  end
end
