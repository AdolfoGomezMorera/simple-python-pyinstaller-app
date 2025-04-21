# Usar la imagen base de Jenkins LTS
FROM jenkins/jenkins:lts

# Cambiar al usuario root para poder instalar dependencias
USER root

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    docker.io

# Crear un entorno virtual para Python
RUN python3 -m venv /opt/venv

# Activar el entorno virtual e instalar los paquetes necesarios
RUN /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install pytest pyinstaller

# Establecer el directorio de trabajo
WORKDIR /var/jenkins_home

# Cambiar al usuario jenkins
USER jenkins

# Exponer el puerto necesario para Jenkins
EXPOSE 8080
