#!groovy
import groovy.json.JsonSlurperClassic
node {
	
	def BUILD_NUMBER=env.BUILD_NUMBER
	def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
	def SFDC_USERNAME
	
	def HUB_ORG=env.HUB_ORG_PROD
	def SFDC_HOST = env.SFDC_HOST_PROD
	def JWT_KEY_CRED_ID = env.JWT_CRED_ID_PROD
	def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_PROD
	
	println 'KEY IS' 
	println JWT_KEY_CRED_ID
	println HUB_ORG
	println SFDC_HOST
	println CONNECTED_APP_CONSUMER_KEY
	def toolbelt = tool 'toolbelt'

	stage('checkout source') {
		// when running in multi-branch job, one must issue this command
	        checkout scm
	}
	
	withEnv(["HOME=${env.WORKSPACE}"]) {
	
		withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
			stage('Deploye Code') {
				env.PATH = env.PATH + ";c:\\Windows\\System32"
				if (isUnix()) {
					rc = sh returnStatus: true, script: "${toolbelt}/sf org login jwt --username ${HUB_ORG} --jwt-key-file ${jwt_key_file} --client-id ${CONNECTED_APP_CONSUMER_KEY} --instance-url ${SFDC_HOST} --set-default-dev-hub"
				}else{
				bat "${toolbelt}/sf update"
				//bat "${toolbelt}/sf org logout --target-org ${HUB_ORG} --no-prompt" 
					 rc = bat returnStatus: true, script: "${toolbelt}/sf org login jwt --username ${HUB_ORG} --jwt-key-file ${jwt_key_file} --client-id ${CONNECTED_APP_CONSUMER_KEY} --instance-url ${SFDC_HOST} --set-default-dev-hub"
				}
			
				if (rc != 0) { 
				println 'inside rc 0'
				error 'hub org authorization failed' 
			}
			else{
				println 'rc not 0'
			}

				println rc
				
				// need to pull out assigned username
				if (isUnix()) {
					//rmsg = sh returnStdout: true, script: "${toolbelt}/sf project deploy start --metadata-dir manifest/. --target-org ${HUB_ORG}"
					rmsg = sh returnStdout: true, script: "${toolbelt}/sf project deploy start --manifest manifest/package.xml --target-org ${HUB_ORG}"
				}else{
					rmsg = bat returnStdout: true, script: "${toolbelt}/sf project deploy start --manifest manifest/package.xml --target-org ${HUB_ORG}"
				   //rmsg = bat returnStdout: true, script: "${toolbelt}/sf project deploy start --metadata-dir manifest/. --target-org ${HUB_ORG}"
				}
				  
				printf rmsg
				println('Hello from a Job DSL script!')
				println(rmsg)
			}
		}
	}

}
