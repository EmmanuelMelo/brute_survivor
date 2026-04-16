package com.brute.brute_api.infra.security;

import com.brute.brute_api.model.User;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;

@Service
public class TokenService {

    @Value("${api.security.token.secret}")
    private String secret;

    // Na 0.12.x, é recomendado usar SecretKey explicitamente
    private SecretKey getSigningKey() {
        return Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
    }

    public String generateToken(User user) {
        return Jwts.builder()
                .issuer("brute-api")
                .subject(user.getUsername())
                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + 86400000)) // 24h
                .signWith(getSigningKey()) // O algoritmo é detectado automaticamente pela chave
                .compact();
    }

    public String validateToken(String token) {
        try {
            return Jwts.parser()
                    .verifyWith(getSigningKey()) // Antigo setSigningKey
                    .build()
                    .parseSignedClaims(token)    // Antigo parseClaimsJws
                    .getPayload()                // Antigo getBody
                    .getSubject();
        } catch (Exception e) {
            return "";
        }
    }
}
