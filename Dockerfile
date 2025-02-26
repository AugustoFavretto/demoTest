# Usar openjdk:17 baseado em Debian
FROM openjdk:17-slim

# Atualizar repositórios e instalar wget e unzip
RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

# Definir o diretório de trabalho no contêiner
WORKDIR /app

# Copiar os arquivos do projeto para o contêiner
COPY . .

# Baixar e configurar o Gradle (se necessário)
RUN wget https://services.gradle.org/distributions/gradle-7.6-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-7.6-bin.zip && \
    rm /tmp/gradle-7.6-bin.zip
ENV PATH="/opt/gradle/gradle-7.6/bin:${PATH}"

# Construir o projeto com Gradle
RUN ./gradlew build

# Expor a porta da aplicação
EXPOSE 8089

# Comando para iniciar a aplicação
CMD ["java", "-jar", "build/libs/demo-0.0.1-SNAPSHOT.jar"]
