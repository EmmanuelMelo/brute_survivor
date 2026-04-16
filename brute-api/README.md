Brute Survivor - API

├── src/main/java/com/brute/brute_api/
│   ├── BruteApiApplication.java
│   ├── controller/
│   │   ├── AuthController.java
│   │   ├── HealthCheckController.java
│   │   └── ScoreController.java
│   ├── dto/
│   │   ├── AuthenticationDTO.java
│   │   ├── LoginResponseDTO.java
│   │   ├── RankingDTO.java
│   │   └── ScoreDTO.java
│   ├── infra/security/
│   │   ├── SecurityConfig.java
│   │   ├── SecurityFilter.java
│   │   └── TokenService.java
│   ├── model/
│   │   ├── Score.java
│   │   └── User.java
│   ├── repository/
│   │   ├── ScoreRepository.java
│   │   └── UserRepository.java
│   └── service/
│       └── AuthorizationService.java
├── src/main/resources/
│   └── application.properties
├── Dockerfile
├── docker-compose.yml
└── pom.xml

Esta é a API REST robusta que gerencia a persistência de usuários, autenticação segura via JWT e o sistema de ranking global para o ecossistema Brute Survivor.

🚀 Tecnologias Utilizadas
    - Java 21
    - Spring Boot 3.x / 7.x (Experimental)
    - Spring Security (Autenticação e Autorização)
    - JWT (JSON Web Token) para comunicações stateless
    - Hibernate/JPA para persistência de dados
    - MySQL 8.0
    - Docker & Docker Compose

    
🛠️ Como Executar o Projeto
    Graças à containerização, você não precisa instalar o Java ou MySQL localmente. Basta ter o Docker instalado.
    1. Clone o repositório: 
        git clone https://github.com/EmmanuelMelo/brute-survivor-api.git
    2. Suba os containers: 
        Bashdocker-compose up --build
        Este comando irá compilar o código Java, baixar as dependências do Maven, criar a imagem do container e subir o banco de dados MySQL automaticamente.
    3. Acesse a API:
        A aplicação estará disponível em http://localhost:8080.

        
🛡️ Endpoints da API
    Autenticação
        Método      Endpoint            Descrição                           Acesso
        POST        /auth/register      Cria um novo sobrevivente           Público
        POST        /auth/login         Autentica e retorna um Token JWT    Público

    Ranking
        Método      Endpoint            Descrição                           Acesso
        GET         /ranking            Retorna o Top 10 recordes           Público
        POST        /ranking            Salva uma nova pontuação            JWT Requerido
        
    Monitoramento
        Método      Endpoint            Descrição                           Acesso
        GET         /health             Verifica o estado da aplicação      Público

        
🔐 Segurança e Autenticação
    A API utiliza Bearer Tokens. Para acessar endpoints protegidos (como salvar pontuação), você deve incluir o token no cabeçalho de sua requisição:
        HTTP
        Authorization: Bearer <seu_token_jwt>

    As senhas dos usuários são protegidas usando o algoritmo de hashing BCrypt antes de serem salvas no banco de dados.
    
    
📊 Estrutura de Dados (Entidades)
    - User: Armazena credenciais (Username e Password criptografada).
    - Score: Registra o valor da pontuação, data da conquista e o vínculo com o usuário.
    Nota: O sistema utiliza DDL-Auto: Update, o que significa que o Hibernate criará e atualizará as tabelas do MySQL automaticamente ao iniciar o container.
    
    
🐳 Variáveis de Ambiente (Docker)
    Caso precise alterar as configurações de conexão, as seguintes variáveis podem ser ajustadas no docker-compose.yml:
    - MYSQL_DATABASE: Nome do banco de dados (Padrão: brute_db).
    - SPRING_DATASOURCE_URL: URL de conexão JDBC.
    - JWT_SECRET: Chave mestra para assinatura dos tokens.


Desenvolvido com foco em performance e segurança para o projeto Brute Survivor. 🎮