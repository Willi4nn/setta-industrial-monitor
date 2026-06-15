# Setta Monitoramento — Sistema de Eficiência Industrial

Plataforma de monitoramento térmico desenvolvida para o desafio técnico da Setta Digital Labs.

## 🛠️ Pré-requisitos

- Mendix Studio Pro 10.24.13
- PostgreSQL 12+
- Driver JDBC PostgreSQL (`postgresql-42.7.11.jar`) na pasta `/userlib`
- Credencial da OpenWeather API

## 💾 Setup do Banco de Dados

1. Execute o PostgreSQL localmente na porta padrão (5432).
2. Crie o banco de dados: `CREATE DATABASE industrial_monitoring;`
3. Execute o script `schema.sql` anexado neste repositório para gerar a estrutura relacional.

## ⚙️ Configuração do Ecossistema Mendix

Por diretrizes de segurança, chaves de API não são versionadas.

1. Abra o projeto no Mendix Studio Pro.
2. Navegue até **App Explorer -> Settings -> Settings -> Active(ou Default) -> Edit**.
3. Na aba **Constants**, configure:
   - `OpenWeather_API_Key`: Insira sua chave de acesso.

## 🚀 Executando Localmente

1. Com o banco de dados ativo, pressione `F5` (Run Locally) no Studio Pro.
2. Acesse o dashboard no navegador via `http://localhost:8080/`.

## 🧠 Decisões Técnicas e Trade-offs

- **Conexão Direta (SQL):** A persistência de dados contorna o ORM nativo do Mendix em favor do _Database Connector_ executando queries SQL parametrizadas para garantir performance e cumprimento dos requisitos.
- **Validação Antecipada:** Regras de negócio e sanitização de ranges térmicos operam em memória antes da persistência, evitando transações falhas no banco.
- **Assincronismo:** O loop de telemetria é gerenciado em segundo plano, garantindo que o dashboard se atualize sem recarregar o DOM da página.
