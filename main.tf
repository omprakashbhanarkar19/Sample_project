resource "null_resource" "create_jenkins_job" {
  provisioner "local-exec" {
    inline = [
       "sh create_jenkins_job.sh"
    ]
}
}