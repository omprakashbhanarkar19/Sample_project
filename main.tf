resource "null_resource" "jenkins_pipeline" {
  provisioner "local-exec" {
    command = "./create_jenkins_job.sh"
  }
}
