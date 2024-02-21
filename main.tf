resource "null_resource" "create_jenkins_job" {
  
   triggers = {
    always_run = "${timestamp()}"
  }
  
  provisioner "local-exec" {
    command = "chmod +x create_jenkins_job.sh"
    command = "./create_jenkins_job.sh"
}

}