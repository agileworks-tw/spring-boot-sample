FROM java:8-jdk
COPY target/spring-boot-sample-data-rest-0.1.0.jar /app/
EXPOSE 8000
WORKDIR /app
CMD /bin/bash -c 'java -jar spring-boot-sample-data-rest-0.1.0.jar'