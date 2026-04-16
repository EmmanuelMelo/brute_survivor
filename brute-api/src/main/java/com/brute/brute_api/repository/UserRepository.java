package com.brute.brute_api.repository;

import com.brute.brute_api.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    // Método que usaremos no login para buscar o usuário pelo nome
    Optional<User> findByUsername(String username);
}