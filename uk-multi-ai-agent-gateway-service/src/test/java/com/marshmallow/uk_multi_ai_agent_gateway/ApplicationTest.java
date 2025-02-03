package com.marshmallow.uk_multi_ai_agent_gateway;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;

import static org.assertj.core.api.Assertions.assertThat;

@SpringTest
class ApplicationTest {
    @Value("${spring.application.name}")
    private String applicationName;

    @Test
    void applicationNameIsSet() {
        assertThat(applicationName).isNotBlank();
    }
}
