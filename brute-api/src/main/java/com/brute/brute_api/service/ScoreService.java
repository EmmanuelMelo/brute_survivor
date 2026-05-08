package com.brute.brute_api.service;

import com.brute.brute_api.dto.RankingDTO;
import com.brute.brute_api.dto.ScoreDTO;
import com.brute.brute_api.model.Score;
import com.brute.brute_api.model.User;
import com.brute.brute_api.repository.ScoreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ScoreService {

    @Autowired
    private ScoreRepository scoreRepository;

    public List<RankingDTO> getRanking() {
        var topScores = scoreRepository.findTop10ByOrderByValueDesc();

        return topScores.stream()
                .map(score -> new RankingDTO(
                        score.getUser().getUsername(),
                        score.getValue(),
                        score.getCreatedAt()
                ))
                .toList();
    }

    public void saveScore(ScoreDTO data, User user) {
        Score score = new Score();
        score.setValue(data.value());
        score.setUser(user);

        scoreRepository.save(score);
    }
}

