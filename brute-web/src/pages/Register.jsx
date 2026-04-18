import { useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../services/api";
import "./Login.css"; // Reaproveitamos os estilos básicos

export default function Register() {
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const navigate = useNavigate();

    const handleRegister = async (e) => {
        e.preventDefault();
        try {
            await api.post('/auth/register', { username, password });
            alert("Herói recrutado com sucesso! Agora faça seu login.");
            navigate("/login");
        } catch (error) {
            alert("Este nome de herói já está em uso ou é inválido.");
        }
    };

    return (
        <div className="pixel-container">
            <form onSubmit={handleRegister} className="pixel-card">
                <div className="logo-container">
                    <img src="/logo.png" alt="Logo" className="pixel-logo" />
                </div>
                <h2 className="pixel-subtitle">NOVO RECRUTA</h2>
                
                <div className="input-group">
                    <label>NOME DO HERÓI</label>
                    <input 
                        className="pixel-input"
                        type="text" 
                        value={username}
                        onChange={e => setUsername(e.target.value)} 
                        maxLength={20}
                        required
                    />
                    <span style={{ 
                        fontSize: '8px', 
                        textAlign: 'right', 
                        color: username.length >= 18 ? '#ff4444' : '#322125' 
                    }}>
                        {username.length}/20
                    </span>
                </div>

                <div className="input-group">
                    <label>CRIE UMA SENHA</label>
                    <input 
                        className="pixel-input"
                        type="password" 
                        value={password}
                        onChange={e => setPassword(e.target.value)} 
                        required
                    />
                </div>

                <button type="submit" className="pixel-button">CADASTRAR</button>
                <button 
                    type="button" 
                    className="pixel-button-secondary" 
                    onClick={() => navigate("/login")}
                >
                    JÁ SOU UM HERÓI
                </button>
            </form>
        </div>
    );
}