import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import api from "../services/api";

export default function Game() {
    const navigate = useNavigate();

    useEffect(() => {
        // Funções globais de comunicação com o Godot
        window.receiveScoreFromGodot = async (score) => {
            try {
                await api.post("/ranking", { value: score });
                console.log("Score salvo!");
            } catch (error) {
                console.error("Erro ao salvar:", error);
            }
        };

        window.redirectToRanking = () => navigate("/ranking");

        return () => {
            delete window.receiveScoreFromGodot;
            delete window.redirectToRanking;
        };
    }, [navigate]);

    const toggleFullscreen = () => {
        const iframe = document.querySelector("iframe");
        if (iframe.requestFullscreen) {
            iframe.requestFullscreen();
        } else if (iframe.webkitRequestFullscreen) { // Safari
            iframe.webkitRequestFullscreen();
        }
    };

    return (
        <div style={{ 
            width: "100vw", 
            height: "100vh", 
            backgroundColor: "#1a1a1a", 
            display: "flex", 
            flexDirection: "column", // Organiza iframe e botões em coluna
            justifyContent: "center", 
            alignItems: "center",
            overflow: "hidden"
        }}>
            {/* A Arena */}
            <iframe 
                src="/game/index.html" 
                title="Brute Survivor Game"
                style={{ 
                    width: "85vw", 
                    height: "70vh", 
                    maxWidth: "1280px",
                    maxHeight: "720px",
                    border: "6px solid #322125",
                    imageRendering: "pixelated",
                    boxShadow: "0 0 40px rgba(0,0,0,0.8)"
                }}
            />

            {/* Painel de Controles */}
            <div style={{ 
                marginTop: "20px", 
                display: "flex", 
                gap: "15px" // Espaço entre os botões
            }}>
                <button 
                    onClick={toggleFullscreen} 
                    className="pixel-button-ui"
                >
                    TELA CHEIA
                </button>

                <button 
                    onClick={() => navigate("/ranking")} 
                    className="pixel-button-ui secondary"
                >
                    VOLTAR AO RANKING
                </button>
            </div>
        </div>
    );
}