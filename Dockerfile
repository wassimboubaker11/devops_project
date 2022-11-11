FROM adoptopenjdk/openjdk11
COPY target/achat-2.2-SNAPSHOT.jar achat-2.2-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/achat-2.2-SNAPSHOT.jar"]


