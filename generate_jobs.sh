#!/bin/bash

generate_project() {
    PROJECT=$1
    BITBUCKET='${BB_URL}'
    CREDENTIALSID='BB_USER'
    JENKINSFILE=Jenkinsfile.openshift
    cat > "./casc_configs/jobs_${PROJECT}.yaml" << EOF
    jobs:
    - script: >
                organizationFolder("${PROJECT}") {
                    description("Bitbucket organization folder for ${PROJECT}")

                    organizations {
                        bitbucket {
                            serverUrl("${BITBUCKET}")
                            repoOwner("${PROJECT}")
                            credentialsId("${CREDENTIALSID}")
                            autoRegisterHooks(false)
                        }
                    }

                    // "Project Recognizers"
                    projectFactories {
                        workflowMultiBranchProjectFactory {
                            scriptPath '${JENKINSFILE}'
                        }
                    }

                    // "Orphaned Item Strategy"
                    orphanedItemStrategy {
                        discardOldItems {
                        daysToKeep(-1)
                        numToKeep(10)
                        }
                    }

                    // discover Branches (workaround due to JENKINS-46202)
                    configure { node ->
                        // node represents <jenkins.branch.OrganizationFolder>
                        def traits = node / 'navigators' / 'com.cloudbees.jenkins.plugins.bitbucket.BitbucketSCMNavigator' / 'traits'
                        traits << 'com.cloudbees.jenkins.plugins.bitbucket.BranchDiscoveryTrait' {
                            strategyId(3) // detect all branches
                        }
                    }           
                }
EOF
}

for p in BD DBD LAKE
do
    generate_project $p
done