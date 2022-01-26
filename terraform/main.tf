resource "google_container_cluster" "default" {
  name        = var.name
  project     = var.project
  location    = var.location
  description = "GKE Cluster for Cloudkite Interview"

  remove_default_node_pool = true
  initial_node_count = var.initial_node_count
}

resource "google_container_node_pool" "default" {
  name       = "${var.name}-node-pool"
  project    = var.project
  location   = var.location
  cluster    = google_container_cluster.default.name
  node_count = 1

  node_config {
    machine_type = var.machine_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
    ]
  }
}