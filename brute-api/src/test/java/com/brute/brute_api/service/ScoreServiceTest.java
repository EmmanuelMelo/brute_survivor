package com.brute.brute_api.service;

import com.brute.brute_api.dto.RankingDTO;
import com.brute.brute_api.dto.ScoreDTO;
import com.brute.brute_api.model.Score;
import com.brute.brute_api.model.User;
import com.brute.brute_api.repository.ScoreRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ScoreServiceTest {

    @Mock
    private ScoreRepository scoreRepository;

    @InjectMocks
    private ScoreService scoreService;

    private User user;

    @BeforeEach
    void setUp() {
        user = new User();
        user.setUsername("player1");
    }

    @Test
    void shouldReturnRankingMappedFromTopScores() {
        Score score = new Score();
        score.setValue(150);
        score.setUser(user);
        score.setCreatedAt(LocalDateTime.of(2026, 5, 8, 10, 0));

        when(scoreRepository.findTop10ByOrderByValueDesc()).thenReturn(List.of(score));

        List<RankingDTO> ranking = scoreService.getRanking();

        assertNotNull(ranking);
        assertEquals(1, ranking.size());
        assertEquals("player1", ranking.get(0).username());
        assertEquals(150, ranking.get(0).value());
        assertEquals(LocalDateTime.of(2026, 5, 8, 10, 0), ranking.get(0).createdAt());
        verify(scoreRepository).findTop10ByOrderByValueDesc();
    }

    @Test
    void shouldSaveScoreWithValueAndUser() {
        ScoreDTO scoreDTO = new ScoreDTO(250);

        scoreService.saveScore(scoreDTO, user);

        ArgumentCaptor<Score> scoreCaptor = ArgumentCaptor.forClass(Score.class);
        verify(scoreRepository).save(scoreCaptor.capture());

        Score savedScore = scoreCaptor.getValue();
        assertEquals(250, savedScore.getValue());
        assertSame(user, savedScore.getUser());
    }
}
