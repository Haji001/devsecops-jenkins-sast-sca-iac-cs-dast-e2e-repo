

FROM maven:3.8.8-eclipse-temurin-11 AS builder
WORKDIR /usr/src/easybuggy
COPY . .
RUN mvn -B package

FROM eclipse-temurin:11-jre
COPY --from=builder /usr/src/easybuggy/target/easybuggy.jar /
CMD ["java", "-jar", "easybuggy.jar"]
