package com.brute.brute_api.dto;

import java.time.LocalDateTime;

public record RankingDTO(String username, Integer value, LocalDateTime createdAt) {}
