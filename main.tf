resource "null_resource" "create_jenkins_job" {
  provisioner "remote-exec" {
    inline = [
       "sh create_jenkins_job.sh"
    ]
}
}