package com.brute.brute_api.service;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.time.LocalDateTime;

@Service
public class HealthService {

    public Map<String, Object> getHealthStatus() {
        return Map.of(
                "status", "UP",
                "message", "Brute API está sobrevivendo!",
                "timestamp", LocalDateTime.now()
        );
    }
}

