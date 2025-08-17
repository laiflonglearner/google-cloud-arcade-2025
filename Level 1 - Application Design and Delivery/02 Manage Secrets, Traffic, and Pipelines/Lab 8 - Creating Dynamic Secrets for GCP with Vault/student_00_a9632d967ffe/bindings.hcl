resource "buckets/qwiklabs-gcp-04-92258e6172e1" {
  roles = [
    "roles/storage.objectAdmin",
    "roles/storage.legacyBucketReader",
  ]
}
