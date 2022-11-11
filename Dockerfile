FROM adoptopenjdk/openjdk11
COPY target/achat-2.2.jar achat-2.2.jar
ENTRYPOINT ["java","-jar","/achat-2.2.jar"]


