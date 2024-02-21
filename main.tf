resource "null_resource" "create_jenkins_job" {
  
   triggers = {
    always_run = "${timestamp()}"
  }
  
  provisioner "local-exec" {
    cammand = "./create_jenkins_job.sh"
}

}