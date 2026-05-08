package com.brute.brute_api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import com.brute.brute_api.service.HealthService;
import java.util.Map;

@RestController
public class HealthCheckController {

    @Autowired
    private HealthService healthService;

    @GetMapping("/health")
    public Map<String, Object> healthCheck() {
        return healthService.getHealthStatus();
    }
}