-- 1. Verificar últimas 10 leituras de telemetria
SELECT * FROM sensor_reading ORDER BY timestamp DESC LIMIT 10;

-- 2. Verificar o log de anomalias/alertas gerados
SELECT * FROM alert ORDER BY timestamp DESC;

-- 3. Análise de tendências de temperatura e eficiência ao longo do tempo (média por hora)
SELECT
  DATE_TRUNC('hour', timestamp) AS hora,
  ROUND(AVG(temperature)::NUMERIC, 2) AS temp_media,
  ROUND(AVG(efficiency)::NUMERIC, 2) AS efic_media,
  COUNT(*) AS total_leituras
FROM sensor_reading
GROUP BY DATE_TRUNC('hour', timestamp)
ORDER BY hora DESC;

-- 4. Distribuição percentual de leituras por faixa de eficiência
SELECT
  CASE
    WHEN efficiency < 30 THEN 'CRITICA (< 30%)'
    WHEN efficiency < 60 THEN 'BAIXA (30-60%)'
    WHEN efficiency < 85 THEN 'NORMAL (60-85%)'
    ELSE 'OTIMA (>= 85%)'
  END AS faixa,
  COUNT(*) AS total,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentual
FROM sensor_reading
GROUP BY 1
ORDER BY 1;

-- 5. Identificar leituras com status diferente de 'OK' para análise de falhas
SELECT * FROM sensor_reading WHERE status != 'OK';
