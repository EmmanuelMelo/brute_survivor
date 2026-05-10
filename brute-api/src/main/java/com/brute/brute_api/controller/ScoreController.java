package com.brute.brute_api.controller;

import com.brute.brute_api.dto.RankingDTO;
import com.brute.brute_api.dto.ScoreDTO;
import com.brute.brute_api.model.User;
import com.brute.brute_api.service.ScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/ranking")
public class ScoreController {

    @Autowired
    private ScoreService scoreService;

    @GetMapping
    public ResponseEntity<List<RankingDTO>> getRanking() {
        return ResponseEntity.ok(scoreService.getRanking());
    }

    @PostMapping
    public ResponseEntity<Void> saveScore(@RequestBody ScoreDTO data, Authentication authentication) {
        User user = (User) authentication.getPrincipal();
        scoreService.saveScore(data, user);
        return ResponseEntity.ok().build();
    }
}
