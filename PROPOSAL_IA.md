# Visão de Evolução e IA Preditiva

## 1. Proposta de Arquitetura Preditiva
A integração de IA não deve onerar o loop de telemetria em tempo real do Mendix. A arquitetura ideal estabelece o modelo preditivo como um microserviço isolado.
- **Onde rodaria:** Em um container Docker dedicado, expondo um endpoint REST (ex: `/predict` via FastAPI).
- **Alimentação:** O modelo consome o histórico exportado do PostgreSQL para treino contínuo em lotes.
- **Consumo:** O Mendix realiza uma chamada REST para a API preditiva de forma assíncrona, exibindo um badge no dashboard informando a probabilidade de falha térmica nas próximas horas.

## 2. Tecnologias e Stack
- **Machine Learning:** `Python` com `scikit-learn` (Random Forest) para predição supervisionada ou `Prophet` para análise de série temporal.
- **Exposição:** `FastAPI` (alta performance e validação nativa com Pydantic).
- **Mendix:** Consumo nativo via `Call REST Service` e mapeamento JSON.

## 3. Estrutura de Dados e Features
- **Variáveis de Treino:** Temperatura atual, delta de temperatura das últimas 3 leituras, hora do dia (sazonalidade) e a eficiência atrelada.
- **Histórico:** Mínimo de 3 meses de volumetria estável para estabelecer uma baseline de variação térmica confiável.
- **Qualidade:** Dados marcados com status de erro (`status != 'OK'`) são removidos automaticamente do pipeline de treinamento para não enviesar o modelo.

## 4. Melhorias Funcionais (Além da IA)

### I. Relatório de Disponibilidade por Turno
- **Problema:** A visualização em tempo real não permite análise histórica agregada para a gerência.
- **Solução:** Novo painel com filtros de data consolidando a eficiência média por turnos operacionais (Manhã/Tarde/Noite).
- **Valor:** Permite identificar gargalos sazonais que não são visíveis na telemetria imediata.

### II. Notificação Ativa (Push/SMS)
- **Problema:** O operador precisa olhar a tela ativamente para visualizar os alertas críticos.
- **Solução:** Integração com serviços de mensageria (SendGrid/Twilio) disparando avisos em caso de anomalias graves.
- **Valor:** Redução drástica no tempo de inatividade da máquina e tempo de resposta da manutenção.

### III. Suporte Multitenant (Múltiplas Máquinas)
- **Problema:** O design atual atende apenas um nó único de equipamento.
- **Solução:** Inclusão de chaves estrangeiras (`machine_id`) no banco de dados e filtragem dinâmica no dashboard Mendix.
- **Valor:** Escalabilidade comercial que permite à Setta monitorar plantas complexas com dezenas de equipamentos em uma única tela.
