start server
------------

1.	`cd data-rest`
2.	`mvn spring-boot:run`
3.	http://localhost:8080/api

build
-----

`mvn package`

test
----

`mvn test`

run with jar
------------

`java -jar target/spring-boot-sample-data-rest-0.1.0.jar`

run with jar background
-----------------------

`java -jar target/spring-boot-sample-data-rest-0.1.0.jar > /dev/null 2>&1 & echo $! > run.pid`
