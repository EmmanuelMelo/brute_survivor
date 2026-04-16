package com.brute.brute_api.controller;

import com.brute.brute_api.dto.RankingDTO;
import com.brute.brute_api.dto.ScoreDTO;
import com.brute.brute_api.model.Score;
import com.brute.brute_api.model.User;
import com.brute.brute_api.repository.ScoreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/ranking")
public class ScoreController {

    @Autowired
    private ScoreRepository scoreRepository;

    @GetMapping
    public ResponseEntity<List<RankingDTO>> getRanking() {
        var topScores = scoreRepository.findTop10ByOrderByValueDesc();

        // Convertemos a lista de Score para RankingDTO
        var ranking = topScores.stream()
                .map(score -> new RankingDTO(
                        score.getUser().getUsername(), // Pegamos apenas o nome
                        score.getValue(),
                        score.getCreatedAt()
                ))
                .toList();

        return ResponseEntity.ok(ranking);
    }

    @PostMapping
    public ResponseEntity saveScore(@RequestBody ScoreDTO data, Authentication authentication) {
        // O Spring pega o usuário logado do Token automaticamente
        User user = (User) authentication.getPrincipal();

        Score score = new Score();
        score.setValue(data.value()); // Pega o valor do DTO
        score.setUser(user);

        scoreRepository.save(score);
        return ResponseEntity.ok().build();
    }
}
