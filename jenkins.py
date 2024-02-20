import jenkins
import xml.etree.ElementTree as ET

# Jenkins server configuration
jenkins_url = 'http://54.87.147.137:8080/'
jenkins_username = 'admin'
jenkins_password = 'admin123'
jenkins_job_name = 'Sample-project'

# GitHub repository configuration
github_repo_url = 'https://github.com/omprakashbhanarkar19/Sample_project.git'
github_credentials_id = 'your-github-credentials-id'
github_Branch = main

# Connect to Jenkins server
server = jenkins.Jenkins(jenkins_url, username=jenkins_username, password=jenkins_password)

# Define Jenkins job XML
job_xml = f"""
<flow-definition plugin="workflow-job@2.40">
  <actions>
    <org.jenkinsci.plugins.pipeline.modeldefinition.actions.DeclarativeJobAction plugin="pipeline-model-definition@1.8.1"/>
    <org.jenkinsci.plugins.pipeline.modeldefinition.actions.DeclarativeJobPropertyTrackerAction plugin="pipeline-model-definition@1.8.1">
      <jobProperties/>
      <triggers/>
      <parameters/>
      <options/>
    </org.jenkinsci.plugins.pipeline.modeldefinition.actions.DeclarativeJobPropertyTrackerAction>
  </actions>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <org.jenkinsci.plugins.workflow.job.properties.DisableConcurrentBuildsJobProperty/>
    <com.coravy.hudson.plugins.github.GithubProjectProperty plugin="github@1.33.0">
      <projectUrl>{github_repo_url}</projectUrl>
      <displayName></displayName>
    </com.coravy.hudson.plugins.github.GithubProjectProperty>
  </properties>
  <definition class="org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition" plugin="workflow-cps@2.89">
    <scm class="hudson.plugins.git.GitSCM" plugin="git@4.12.0">
      <configVersion>2</configVersion>
      <userRemoteConfigs>
        <hudson.plugins.git.UserRemoteConfig>
          <url>{github_repo_url}</url>
          <credentialsId>{github_credentials_id}</credentialsId>
        </hudson.plugins.git.UserRemoteConfig>
      </userRemoteConfigs>
      <branches>
        <hudson.plugins.git.BranchSpec>
          <name>{github_Branch}</name>
        </hudson.plugins.git.BranchSpec>
      </branches>
      <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
      <submoduleCfg class="list"/>
      <extensions/>
    </scm>
    <scriptPath>Jenkinsfile</scriptPath>
  </definition>
  <triggers>
    <com.cloudbees.jenkins.GitHubPushTrigger plugin="github@1.33.0">
      <spec></spec>
    </com.cloudbees.jenkins.GitHubPushTrigger>
  </triggers>
  <disabled>false</disabled>
</flow-definition>
"""

# Create or update Jenkins job
if server.job_exists(jenkins_job_name):
    server.reconfig_job(jenkins_job_name, job_xml)
    print(f"Updated Jenkins job: {jenkins_job_name}")
else:
    server.create_job(jenkins_job_name, job_xml)
    print(f"Created Jenkins job: {jenkins_job_name}")
