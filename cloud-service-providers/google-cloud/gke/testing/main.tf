


resource "null_resource" "get-signed-ngc-bundle-url" {
  provisioner "local-exec" {
    command = "./fetch-ngc-url.sh > ngc_signed_url.txt"
  }
}
