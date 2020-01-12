job "example" {
  datacenters = ["myhome"]

  group "cache" {
    count = 3
    task "redis" {
      driver = "docker"

      config {
        image = "redis:3.2"

        port_map {
          db = 6379
        }
      }

      resources {
        cpu    = 500
        memory = 256

        network {
          mbits = 10
          port  "db"  {}
        }
      }
      service {
        name = "myredis"
      }
    }
  }
}
