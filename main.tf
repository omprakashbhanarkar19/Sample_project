resource "null_resource" "jenkins_pipeline" {
  provisioner "remote-exec" {
    command = "./create_jenkins_job.sh"
  }
}
