FROM jenkins/jenkins:lts

USER root

RUN /usr/local/bin/install-plugins.sh configuration-as-code 

RUN /usr/local/bin/install-plugins.sh workflow-aggregator
RUN /usr/local/bin/install-plugins.sh bitbucket
RUN /usr/local/bin/install-plugins.sh cloudbees-bitbucket-branch-source
RUN /usr/local/bin/install-plugins.sh job-dsl
RUN /usr/local/bin/install-plugins.sh branch-api
RUN /usr/local/bin/install-plugins.sh pipeline-utility-steps
RUN /usr/local/bin/install-plugins.sh blueocean

COPY ./casc_configs /var/jenkins_home/casc_configs

ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_configs

USER jenkins