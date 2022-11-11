FROM adoptopenjdk/openjdk11
COPY target/achat-2.1.jar achat-2.1.jar
ENTRYPOINT ["java","-jar","/achat-2.1.jar"]


