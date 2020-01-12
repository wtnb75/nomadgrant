client {
  enabled = true
  network_interface = "{{nomad_client_interface}}"
  server_join {
    retry_join = {{nomad_join_address | to_json}}
    retry_max = 3
    retry_interval = "15s"
  }
}
