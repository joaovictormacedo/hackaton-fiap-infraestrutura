resource "google_artifact_registry_repository" "spotmusic-repository" {
  location = var.region
  repository_id = "spotmusic"
  description = "Imagens Docker da SpotMusic"
  format = "DOCKER"
}