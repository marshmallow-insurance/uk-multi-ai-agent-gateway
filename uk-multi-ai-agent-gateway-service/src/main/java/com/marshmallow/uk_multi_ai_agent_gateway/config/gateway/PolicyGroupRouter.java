package com.marshmallow.uk_multi_ai_agent_gateway.config.gateway;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.function.RouterFunction;
import org.springframework.web.servlet.function.ServerResponse;

import static org.springframework.cloud.gateway.server.mvc.handler.GatewayRouterFunctions.route;
import static org.springframework.cloud.gateway.server.mvc.handler.HandlerFunctions.http;
import static org.springframework.cloud.gateway.server.mvc.predicate.GatewayRequestPredicates.path;

@Configuration
public class PolicyGroupRouter {

    @Value("${services.policy-group}")
    private String policyGroupService;

    @Bean
    public RouterFunction<ServerResponse> customerRoute() {
        return route("policyGroupRoute")
            .route(path("/internal/policy-groups/**"), http(policyGroupService))
            .build();
    }

}
