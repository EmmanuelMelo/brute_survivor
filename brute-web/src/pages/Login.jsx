import { useState, useContext } from "react";
import { AuthContext } from "../context/AuthContext";
import "./Login.css";
import { useNavigate } from "react-router-dom";

export default function Login() {
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState(""); // Adicionado estado da senha
    const { login } = useContext(AuthContext);
    const navigate = useNavigate();

    const handleSubmit = async (e) => {
        e.preventDefault();
        
        // Agora enviamos os dois valores para a nossa função de login
        const success = await login(username, password);
        
        if (success) {
            navigate("/ranking");
            // No futuro, aqui faremos o redirecionamento
        } else {
            alert("Usuário ou senha inválidos!");
        }
    };

    return (
        <div className="pixel-container">
            <form onSubmit={handleSubmit} className="pixel-card">
                <div className="logo-container">
                    <img 
                        src="/Brute logo.png" 
                        alt="Brute Survivor Logo" 
                        className="pixel-logo" 
                    />
                </div>
                
                {/* Campo do Usuário */}
                <div className="input-group">
                    <label>LOGIN</label>
                    <input 
                        className="pixel-input"
                        type="text" 
                        placeholder="Ex: Muriel"
                        value={username}
                        onChange={e => setUsername(e.target.value)} 
                        required
                    />
                </div>

                {/* NOVO: Campo da Senha */}
                <div className="input-group">
                    <label>SENHA</label>
                    <input 
                        className="pixel-input"
                        type="password" 
                        placeholder="********"
                        value={password}
                        onChange={e => setPassword(e.target.value)} 
                        required
                    />
                </div>

                <button type="submit" className="pixel-button">
                    ENTRAR NA LUTA
                </button>

                <div className="register-link">
                    <span>Novo por aqui? </span>
                    <button 
                        type="button" 
                        className="pixel-button-secondary" 
                        onClick={() => navigate("/register")}
                    >
                        CRIAR CONTA
                    </button>
                </div>
            </form>
        </div>
    );
}