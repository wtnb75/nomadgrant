server {
  enabled = true
  bootstrap_expect = 3
  server_join {
    retry_join = {{nomad_join_address | to_json}}
    retry_max = 3
    retry_interval = "15s"
  }
}
