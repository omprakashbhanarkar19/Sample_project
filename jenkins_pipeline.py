import jenkins
import xml.etree.ElementTree as ET

# Jenkins server configuration
jenkins_url = 'http://54.87.147.137:8080/'
jenkins_username = 'admin'
jenkins_password = 'admin123'
jenkins_job_name = 'demo-project'

# GitHub repository configuration
github_repo_url = 'https://github.com/omprakashbhanarkar19/Sample_project.git'
github_credentials_id = 'your-github-credentials-id'

# #create pre-configured-job
job_xml = open("job.xml", mode='r', encoding='utf-8').read()
server.create_job("job", job_xml)

# Connect to Jenkins server
server = jenkins.Jenkins(jenkins_url, username=jenkins_username, password=jenkins_password)

# Create or update Jenkins job
if server.job_exists(jenkins_job_name):
    server.reconfig_job(jenkins_job_name, job)
    print(f"Updated Jenkins job: {jenkins_job_name}")
else:
    server.create_job(jenkins_job_name, job)
    print(f"Created Jenkins job: {jenkins_job_name}")
