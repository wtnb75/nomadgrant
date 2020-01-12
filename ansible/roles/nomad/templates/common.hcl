region = "{{regionname}}"
datacenter = "{{dcname}}"
data_dir = "/var/nomad"
bind_addr = "0.0.0.0"
disable_update_check = true
name = "{{inventory_hostname_short}}"

advertise {
  http = "{%raw%}{{{%endraw%} GetInterfaceIP \"{{nomad_interface}}\" {%raw%}}}{%endraw%}"
  rpc = "{%raw%}{{{%endraw%} GetInterfaceIP \"{{nomad_interface}}\" {%raw%}}}{%endraw%}"
  serf = "{%raw%}{{{%endraw%} GetInterfaceIP \"{{nomad_interface}}\" {%raw%}}}{%endraw%}"
}

consul {
  auto_advertise = true
  server_auto_join = true
  client_auto_join = true
}
