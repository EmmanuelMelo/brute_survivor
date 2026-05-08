package com.brute.brute_api.service;

import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

class HealthServiceTest {

    private final HealthService healthService = new HealthService();

    @Test
    void shouldReturnHealthStatusWithExpectedFields() {
        Map<String, Object> healthStatus = healthService.getHealthStatus();

        assertNotNull(healthStatus);
        assertEquals("UP", healthStatus.get("status"));
        assertEquals("Brute API está sobrevivendo!", healthStatus.get("message"));
        assertNotNull(healthStatus.get("timestamp"));
        assertEquals(LocalDateTime.class, healthStatus.get("timestamp").getClass());
    }
}
