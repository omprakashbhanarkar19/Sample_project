resource "null_resource" "jenkins_pipeline" {
  provisioner "remote-exec" {
    inline = [
       "sh create_jenkins_job.sh"
    ]
}
}