FROM adoptopenjdk/openjdk11
COPY target/achat-2.0.jar achat-2.0.jar
ENTRYPOINT ["java","-jar","/achat-2.0.jar"]


