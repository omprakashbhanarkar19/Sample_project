resource "null_resource" "name" {
  provisioner "remote-exec" {
    inline = [
       "sh create_jenkins_job.sh"
    ]
}
}