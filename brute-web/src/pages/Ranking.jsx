import { useEffect, useState } from "react";
import api from "../services/api";
import "./Ranking.css";
import { useContext } from "react";
import { useNavigate } from "react-router-dom";
import { AuthContext } from "../context/AuthContext";

export default function Ranking() {
    const { logout } = useContext(AuthContext);
    const navigate = useNavigate();
    const [scores, setScores] = useState([]);

    useEffect(() => {
        const token = localStorage.getItem('token');

        // 1. Verificação de segurança: Se não tem token, tchau!
        if (!token) {
            navigate("/login", { replace: true });
            return;
        }
        // Busca o Top 10 que configuramos no Spring Boot
        api.get("/ranking")
            .then(response => setScores(response.data))
            .catch(err => {console.error("Erro ao buscar ranking", err);
            if (err.response?.status === 403 || err.response?.status === 401) {
                logout();
                navigate("/login");
            }
        });
}, [navigate, logout]);

    const handleLogout = () => {
        logout();
        navigate("/login", { replace: true });
    };

    return (
        <div className="ranking-container">
            <div className="ranking-board">
                <h1 className="ranking-title">Top Sobreviventes</h1>
                <table className="pixel-table">
                    <thead>
                        <tr>
                            <th>POS</th>
                            <th>HERÓI</th>
                            <th>DATA</th>
                            <th>SCORE</th>
                        </tr>
                    </thead>
                    <tbody>
                        {scores.map((score, index) => (
                            <tr key={index}>
                                <td>#{index + 1}</td>
                                <td>{score.username}</td>
                                <td>
                                    {score.createdAt ? new Date(score.createdAt).toLocaleDateString('pt-BR', {
                                        day: '2-digit',
                                        month: '2-digit',
                                        year: 'numeric'
                                    }) : "--/--/----"}
                                </td>
                                <td className="score-value">{score.value}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
                <button 
                    className="pixel-button-play" 
                    onClick={() => navigate("/game")}
                >
                    JOGAR
                </button>

                <button className="pixel-button-back" onClick={handleLogout}>
                    SAIR DA CONTA
                </button>
            </div>
        </div>
    );
}