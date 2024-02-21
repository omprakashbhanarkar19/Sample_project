resource "null_resource" "create_jenkins_job" {
  provisioner "local-exec" {
    cammand = "./create_jenkins_job.sh"
}
}