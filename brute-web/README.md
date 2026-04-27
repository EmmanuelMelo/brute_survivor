⚔️ Brute Survivor - Web Interface
    Este repositório contém o frontend do projeto Brute Survivor, uma interface web desenvolvida em React para gerenciar o acesso dos heróis e exibir o lendário Ranking de Sobreviventes. A estética é inspirada pixel artes de games retô, utilizando os assets do pack Tiny Swords.


🎨 Identidade Visual e UI
    O projeto foca em uma experiência imersiva de jogo mesmo fora da arena:
     - Pixel Art Rendering: Configurações de CSS para garantir que cada pixel permaneça nítido (image-rendering: pixelated).
     - Responsividade: Interface adaptada para diferentes resoluções, mantendo o aspecto de "placa de madeira" centralizada.


🛠️ Tecnologias Utilizadas
    Tecnologia:              Descrição:
    React 18                 Biblioteca principal para construção da interface.
    Vite                     Ferramenta de build de próxima geração para um desenvolvimento rápido.
    React Router DOM         Gerenciamento de rotas e navegação entre telas.
    Axios                    Cliente HTTP para comunicação com a Brute API.
    Context API              Gerenciamento de estado global para autenticação (JWT).
    CSS Modules/Global       Estilização personalizada focada em fidelidade à Pixel Art.


🚀 Funcionalidades
    🔐 Autenticação de Heróis: Sistema de Login e Cadastro com validação de credenciais.
    🏆 Ranking Global: Exibição em tempo real dos 10 melhores guerreiros, com data da conquista e pontuação.
    🛡️ Proteção de Rotas: Acesso ao ranking permitido apenas para usuários autenticados.
    🚪 Logout Seguro: Encerramento de sessão com limpeza de tokens e histórico de navegação.


📂 Estrutura do Projeto
    src/
 ├── assets/          # Sprites, logotipos e backgrounds
 ├── context/         # AuthContext (Gerenciamento de sessão)
 ├── pages/           
 │    ├── Login/      # Tela de entrada
 │    ├── Ranking/    # Exibição dos Top 10
 │    └── Game/       # Arena com Iframe e controles de UI
 ├── services/        # Configuração da API (Axios instance)
 └── App.jsx          # Definição de rotas protegidas
public/
 └── game/            # Arquivos exportados do Godot (.wasm, .pck, .js)


🔧 Configuração e Instalação
    Pré-requisitos
     - Node.js (v18+) ou Docker.
     - Brute API rodando (preferencialmente na porta 8080).
    
    Instalação Local
     1. Clone o repositório:
        git clone https://github.com/EmmanuelMelo/brute-web.git
     2. Instale as dependências:
        npm install
     3. Inicie o servidor de desenvolvimento:
        npm run dev

    Variáveis de Ambiente
     - Crie um arquivo .env na raiz do projeto:
        VITE_API_URL=http://localhost:8080

    
🐳 Docker (Ambiente de Desenvolvimento)
    O projeto está pronto para rodar em containers, facilitando a orquestração com a API e o Banco de Dados.
        Para subir apenas o frontend
         - docker-compose up brute-web
        Para buildar após mudanças no código
         - docker-compose up --build brute-web