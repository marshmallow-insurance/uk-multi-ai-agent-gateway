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
public class RenewalsQuotingRouter {

    @Value("${services.renewals-quoting}")
    private String renewalsQuotingService;

    @Bean
    public RouterFunction<ServerResponse> renewalsQuotingRoute() {
        return route("renewalsQuotingRoute")
            .before(stripPrefix(1))
            .before(removeRequestHeader(AUTHORIZATION).andThen(removeRequestHeader(COOKIE)))
            .route(path("/renewals-quoting/**"), http(renewalsQuotingService))
            .build();
    }

}
