docker run -it --rm \
    --name jenkins \
    -p 8080:8080 \
    -p 50000:50000 \
    -v $(pwd)/casc_configs:/var/jenkins_home/casc_configs \
    -e BB_USER=$BB_USER \
    -e BB_PASS=$BB_PASS \
    -e BB_URL=$BB_URL \
    custom-jenkins