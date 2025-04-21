FROM jenkins/jenkins:lts

USER root

# Instalar Docker CLI
RUN apt-get update && apt-get install -y docker.io

# Instalar dependencias necesarias
RUN apt-get install -y python3 python3-pip
RUN pip3 install pytest pyinstaller

USER jenkins
