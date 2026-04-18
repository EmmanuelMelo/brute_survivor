// 1. IMPORTANTE: Adicionei o 'useEffect' aqui no import!
import { createContext, useState, useEffect } from "react"; 
import api from "../services/api";

export const AuthContext = createContext({});

export const AuthProvider = ({ children }) => {
    const [user, setUser] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const token = localStorage.getItem('token');
        if (token) {
            api.defaults.headers.Authorization = `Bearer ${token}`;
            setUser({ logged: true });
        }
        setLoading(false);
    }, []);

    const login = async (username, password) => {
        try {
            const response = await api.post('/auth/login', { username, password });
            const { token } = response.data;
            
            localStorage.setItem('token', token);
            setUser({ username });
            api.defaults.headers.Authorization = `Bearer ${token}`;
            
            return true;
        } catch (error) {
            console.error("Erro no login", error);
            return false;
        }
    };

    const logout = () => {
        localStorage.removeItem('token');
        setUser(null);
        delete api.defaults.headers.Authorization;
    };

    // 2. LÓGICA DE LOADING: 
    // Enquanto estiver checando o token, não renderizamos nada (ou um loading)
    // Isso evita que a tela de login apareça por um milissegundo para quem já está logado.
    if (loading) {
        return null; // Ou um <div className="pixel-text">CARREGANDO...</div>
    }

    return (
        <AuthContext.Provider value={{ user, login, logout }}>
            {children}
        </AuthContext.Provider>
    );
};