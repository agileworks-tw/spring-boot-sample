start-docker-registry:
	- docker run -d -p 5000:5000 --restart=always --name registry registry:2


build-docker-env:
	docker build -t localhost:5000/maven dockers/maven

build-docker-prod-image:
	docker build -t localhost:5000/java_sample_prod .
	docker push localhost:5000/java_sample_prod

deploy-production-local:
	- docker rm -f java_sample_prod 
	docker run -d --name java_sample_prod -p 8800:8000 localhost:5000/java_sample_prod


deploy-production-ssh:
	- ssh jenkins@localhost docker rm -f java_sample_prod
	ssh jenkins@localhost docker run -d --name java_sample_prod -p 8800:8000 localhost:5000/java_sample_prod

deploy-default:
	ssh jenkins@localhost mkdir -p deploy/release
	scp target/spring-boot-sample-data-rest-0.1.0.jar jenkins@localhost:deploy/release
	- ssh jenkins@localhost 'kill `cat deploy/release/run.pid`'
	ssh jenkins@localhost 'java -jar deploy/release/spring-boot-sample-data-rest-0.1.0.jar > /dev/null 2>&1 & echo $$! > "deploy/release/run.pid"'

init-registry-images:
	docker pull alpine
	docker tag alpine:latest localhost:5000/alpine:latest
	docker push localhost:5000/alpine
	docker rmi -f alpine localhost:5000/alpine
	
	docker pull anapsix/alpine-java
	docker tag anapsix/alpine-java:latest localhost:5000/alpine-java:latest
	docker push localhost:5000/alpine-java
	docker rmi -f anapsix/alpine-java localhost:5000/alpine-java
	
	docker pull ubuntu
	docker tag ubuntu:latest localhost:5000/ubuntu:latest
	docker push localhost:5000/ubuntu
	docker rmi -f ubuntu localhost:5000/ubuntu
	
	docker build -t localhost:5000/maven dockers/maven
	docker push localhost:5000/maven
	docker rmi -f localhost:5000/maven
	
	docker pull training/webapp
	docker tag training/webapp:latest localhost:5000/training-webapp:latest
	docker push localhost:5000/training-webapp
	docker rmi -f training/webapp localhost:5000/training-webapp
	
	docker pull training/postgres
	docker tag training/postgres:latest localhost:5000/training-postgres:latest
	docker push localhost:5000/training-postgres
	docker rmi -f training/postgres localhost:5000/training-postgres