FROM 007126583757.dkr.ecr.eu-west-1.amazonaws.com/java-base:5.0.2-119
COPY --chown=root:root ./uk-multi-ai-agent-gateway-service/target/uk-multi-ai-agent-gateway-*.jar service.jar
