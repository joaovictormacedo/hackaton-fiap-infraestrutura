resource "google_sql_database_instance" "spotmusic-database-instance" {
  name             = "spotmusic"
  database_version = "MYSQL_5_7"
  project          = var.project_name

  settings {
    tier = "db-n1-standard-1"

    backup_configuration {
      enabled     = true
      start_time  = "23:00"
      binary_log_enabled = false
    }

    ip_configuration {
      ipv4_enabled    = true
    }
  }
}

resource "google_sql_database" "spotmusic-database" {
  name     = "playlist"
  instance = google_sql_database_instance.spotmusic-database-instance.name
  charset  = "utf8"
  collation = "utf8_general_ci"

  depends_on = [ google_sql_database_instance.spotmusic-database-instance ] 
}

resource "google_sql_user" "database_user" {
  name     = "playlist"
  instance = google_sql_database_instance.spotmusic-database-instance.name
  password = "abc12345678#*"

  depends_on = [ google_sql_database_instance.spotmusic-database-instance ]
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "cat playlist.sql | gcloud sql connect ${google_sql_database_instance.spotmusic-database-instance.connection_name} --user=playlist --password=abc12345678#*"
  }

  depends_on = [google_sql_database.spotmusic-database, google_sql_user.database_user]
}