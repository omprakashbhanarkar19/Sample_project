@Grab('org.codehaus.groovy.modules.http-builder:http-builder:0.7.1')

import groovyx.net.http.RESTClient

// Jenkins server configuration
def jenkinsUrl = 'http://54.87.147.137:8080/'
def jenkinsUsername = 'admin'
def jenkinsPassword = 'admin123'
def jenkinsJobName = 'demo-project'

// GitHub repository configuration
def githubRepoUrl = 'https://github.com/omprakashbhanarkar19/Sample_project.git'
def githubCredentialsId = 'your-github-credentials-id'

// Connect to Jenkins server
def server = new RESTClient(jenkinsUrl)
server.auth.basic(jenkinsUsername, jenkinsPassword)

// Define Jenkins job XML
def jobXml = """
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
      <projectUrl>${githubRepoUrl}</projectUrl>
      <displayName></displayName>
    </com.coravy.hudson.plugins.github.GithubProjectProperty>
  </properties>
  <definition class="org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition" plugin="workflow-cps@2.89">
    <scm class="hudson.plugins.git.GitSCM" plugin="git@4.12.0">
      <configVersion>2</configVersion>
      <userRemoteConfigs>
        <hudson.plugins.git.UserRemoteConfig>
          <url>${githubRepoUrl}</url>
          <credentialsId>${githubCredentialsId}</credentialsId>
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
"""

// Create or update Jenkins job
def response = server.post(
    path: '/createItem',
    body: [name: jenkinsJobName, mode: 'xml'],
    contentType: 'application/xml',
    requestContentType: groovyx.net.http.ContentType.XML,
    body: jobXml
)

if (response.status == 200) {
    println "Jenkins job ${jenkinsJobName} created or updated successfully."
} else {
    println "Failed to create or update Jenkins job. Status code: ${response.status}"
}
