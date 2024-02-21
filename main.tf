resource "null_resource" "create_jenkins_job" {
  provisioner "local-exec" {
    cammand = "sh create_jenkins_job.sh"
}
}