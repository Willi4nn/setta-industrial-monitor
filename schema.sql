-- Criação da tabela de telemetria principal
CREATE TABLE sensor_reading (
    id          SERIAL PRIMARY KEY,
    timestamp   TIMESTAMP NOT NULL DEFAULT NOW(),
    temperature NUMERIC(5,2) NOT NULL,
    efficiency  NUMERIC(5,2) NOT NULL,
    status      VARCHAR(20) NOT NULL DEFAULT 'OK'
);

-- Criação da tabela de auditoria de anomalias
CREATE TABLE alert (
    id               SERIAL PRIMARY KEY,
    timestamp        TIMESTAMP NOT NULL DEFAULT NOW(),
    alert_type       VARCHAR(50) NOT NULL,
    description      TEXT,
    temperature_ref  NUMERIC(5,2),
    efficiency_ref   NUMERIC(5,2)
);

-- Exemplo de inserção de dados na tabela de telemetria
INSERT INTO sensor_reading (temperature, efficiency, status)
VALUES (25.5, 65.45, 'OK');
