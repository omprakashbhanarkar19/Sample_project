resource "null_resource" "create_jenkins_job" {
  
   triggers = {
    always_run = "${timestamp()}"
  }
  
  provisioner "local-exec" {
    command = "./create_jenkins_job.sh"
}

}