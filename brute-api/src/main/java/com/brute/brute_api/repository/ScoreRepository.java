package com.brute.brute_api.repository;

import com.brute.brute_api.model.Score;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ScoreRepository extends JpaRepository<Score, Long> {
    // Busca os 10 maiores scores ordenados do maior para o menor
    List<Score> findTop10ByOrderByValueDesc();
}
