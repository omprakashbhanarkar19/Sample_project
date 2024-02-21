#!/bin/bash

# Jenkins server configuration
jenkins_url="http://52.90.131.170:8080/"
jenkins_username="admin"
jenkins_password="admin123"
jenkins_job_name="demo-project"

# GitHub repository configuration
github_repo_url="https://github.com/omprakashbhanarkar19/Sample_project.git"
github_credentials_id="your-github-credentials-id"

# Define Jenkins job XML
job_xml=$(cat <<EOF
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
      <projectUrl>${github_repo_url}</projectUrl>
      <displayName></displayName>
    </com.coravy.hudson.plugins.github.GithubProjectProperty>
  </properties>
  <definition class="org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition" plugin="workflow-cps@2.89">
    <scm class="hudson.plugins.git.GitSCM" plugin="git@4.12.0">
      <configVersion>2</configVersion>
      <userRemoteConfigs>
        <hudson.plugins.git.UserRemoteConfig>
          <url>${github_repo_url}</url>
          <credentialsId>${github_credentials_id}</credentialsId>
        </hudson.plugins.git.UserRemoteConfig>
      </userRemoteConfigs>
      <branches>
        <hudson.plugins.git.BranchSpec>
          <name>main</name>
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
EOF
)

# Create or update Jenkins job
if curl --user "${jenkins_username}:${jenkins_password}" -X POST "${jenkins_url}/createItem?name=${jenkins_job_name}" -H "Content-Type:application/xml" -d "${job_xml}" -o /dev/null -w "%{http_code}" | grep -q "200"; then
    echo "Jenkins job ${jenkins_job_name} created or updated successfully."
else
    echo "Failed to create or update Jenkins job."
fi