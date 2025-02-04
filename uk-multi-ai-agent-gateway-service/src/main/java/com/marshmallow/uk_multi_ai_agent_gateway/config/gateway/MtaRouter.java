package com.marshmallow.uk_multi_ai_agent_gateway.config.gateway;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.function.RouterFunction;
import org.springframework.web.servlet.function.ServerResponse;

import static org.springframework.cloud.gateway.server.mvc.filter.BeforeFilterFunctions.removeRequestHeader;
import static org.springframework.cloud.gateway.server.mvc.filter.BeforeFilterFunctions.stripPrefix;
import static org.springframework.cloud.gateway.server.mvc.handler.GatewayRouterFunctions.route;
import static org.springframework.cloud.gateway.server.mvc.handler.HandlerFunctions.http;
import static org.springframework.cloud.gateway.server.mvc.predicate.GatewayRequestPredicates.path;
import static org.springframework.http.HttpHeaders.AUTHORIZATION;
import static org.springframework.http.HttpHeaders.COOKIE;

@Configuration
public class MtaRouter {

    @Value("${services.mta}")
    private String mtaService;

    @Bean
    public RouterFunction<ServerResponse> mtaRoute() {
        return route("mtaRoute")
            .before(stripPrefix(1))
            .before(removeRequestHeader(AUTHORIZATION).andThen(removeRequestHeader(COOKIE)))
            .route(path("/mta/**"), http(mtaService))
            .build();
    }

}
