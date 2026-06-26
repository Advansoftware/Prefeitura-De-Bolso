# 📅 Volume 8 — Cronograma e Implantação

## Projeto "Prefeitura de Brazópolis"

---

## Sumário

1. [Fases do Projeto e Cronograma](#1-fases-do-projeto-e-cronograma)
2. [Gestão de Sprints](#2-gestão-de-sprints)
3. [Estratégia de Lançamento (Lojas)](#3-estratégia-de-lançamento-lojas)
4. [CI/CD (Integração e Entrega Contínuas)](#4-cicd-integração-e-entrega-contínuas)
5. [Custos de Nuvem Estimados](#5-custos-de-nuvem-estimados)
6. [Métricas de Sucesso (KPIs)](#6-métricas-de-sucesso-kpis)

---

## 1. Fases do Projeto e Cronograma

O projeto segue um modelo Ágil (Scrum) dividido em 4 Sprints quinzenais, totalizando **8 semanas (2 meses)** para a primeira versão pública (MVP).

| Fase | Descrição | Duração | Marco Entregável |
|------|-----------|---------|------------------|
| **Discovery e Design** | (Concluído) Requisitos, Mockups, Arquitetura. | 1 Semana | Documentos Vol 1 a 8 aprovados, 20 mockups |
| **Fase 1: Fundação** | Setup do app, arquitetura base, integração do design system. Implementação dos módulos base (Home, Notícias, Saúde, Educação, Turismo) consumindo APIs já existentes. | 2 Semanas | App rodando com navegação e consumo das APIs antigas (Leitura). |
| **Fase 2: Interatividade** | Desenvolvimento dos novos endpoints em NestJS (Protocolos, Coleta de Lixo, Eventos). Integração FCM para push. App consome e envia novos dados. | 2 Semanas | Backend estendido; App criando protocolos (câmera, GPS) e push funcionando. |
| **Fase 3: Wrapper e Polimento** | Integração IPTU, mapa inteligente avançado, Whatsapp, preferências e offline. | 2 Semanas | Feature Freeze (Todas as features prontas). App cacheando dados offline. |
| **Fase 4: QA e Deploy** | Testes de carga no backend, Testes E2E, envio para as lojas, beta testers internos. | 1 Semana | App aprovado pela Apple e Google. Go-live. |

---

## 2. Gestão de Sprints

### Sprint 1: Frontend Base
- Scaffold do Flutter, injeção de dependência.
- Configuração do tema e identidade visual (Cores, Fontes, Componentes Base).
- Construção das telas: Splash, Onboarding, Home (com carousel de banners e grid).
- Integração da Busca Global (MeiliSearch).
- Telas de listagem que já têm API (Notícias, Saúde, Turismo).

### Sprint 2: Core Novo Backend + Flutter
- Backend: Criar CRUD e APIs REST para Protocolo.
- Backend: Configurar MinIO e rotas de upload de imagem.
- App: Câmera + Geolocator. Fluxo de abrir protocolo.
- App: Banco local SQLite para salvar os códigos gerados.

### Sprint 3: Notificações e Outros Módulos
- Backend: Registro de token de device + rotas de disparo de push.
- Firebase: Setup de chaves FCM.
- App: Configurações, toggles de notificações.
- App: Módulo IPTU.
- App: Tratativas offline (SharedPreferences / Isar).

### Sprint 4: QA e Lojas
- Resolução de bugs da Sprint 1-3.
- Geração de ícones, splash screens (vários tamanhos).
- Preparar screenshots para as stores (baseados nos mockups).
- Submissão (revisão de privacidade da Apple).

---

## 3. Estratégia de Lançamento (Lojas)

Para um app governamental, o processo nas lojas exige contas especiais e documentação legal:

### 3.1 Contas de Desenvolvedor
- **Apple (iOS):** É obrigatório que a conta seja **Corporativa e de Entidade Governamental** (isenta de taxa anual em alguns casos). O DUNS Number da Prefeitura precisa ser fornecido. A Apple rejeita apps do governo publicados em contas de empresas terceirizadas.
- **Google Play:** Conta de desenvolvedor vinculada à Prefeitura. Formulários extras declarando que é um "aplicativo oficial governamental".

### 3.2 Revisão de Privacidade
O app não coleta dados pessoais identificáveis (PII). Logo:
- Privacy Policy na loja indicará: "Nenhum dado é vinculado ao usuário".
- Coleta de localização e FCM precisam estar explicitadas na Privacy Policy (apenas uso anônimo funcional).

### 3.3 Soft Launch
- Lançamento beta para 50 funcionários da prefeitura por 7 dias.
- Teste real da ferramenta de protocolos.
- Correção rápida (Hotfixes) via Codemagic.
- Anúncio público (marketing local).

---

## 4. CI/CD (Integração e Entrega Contínuas)

### 4.1 Backend (NestJS)
- **Onde:** GitHub Actions → Push no `main` → Deploy no servidor Coolify.
- **Jobs:** Lint, Test, Docker Build, Atualizar container.
- **Tempo médio de deploy:** 5 minutos.

### 4.2 Frontend (Flutter)
- **Ferramenta recomendada:** Codemagic (especializado em Flutter) ou GitHub Actions.
- **Workflow `pr_check`:** Roda `flutter analyze` e `flutter test` em todo PR aberto.
- **Workflow `beta_release`:** Gera APK (Android) e IPA (iOS) ad-hoc e envia para o Firebase App Distribution ao fazer push na branch `beta`.
- **Workflow `production_release`:** Gera os builds assinados com keystore e certificados p12 de produção, faz upload automático via API da Google Play Console e App Store Connect TestFlight.

---

## 5. Custos de Nuvem Estimados

A filosofia do projeto é **não aumentar custos significativamente**, usando a infraestrutura do site existente.

| Componente | Ferramenta | Custo Estimado (mês) | Observação |
|------------|------------|----------------------|------------|
| Servidor API | VPS Existente | $0 (aproveitado) | NestJS e MySQL já hospedados |
| Servidor Cache | Mesmo VPS | $0 (aproveitado) | Redis adicionado no mesmo server docker |
| Storage Imagens | MinIO (no VPS) | $0 (aproveitado) | Espaço em disco sob demanda (S3 compatible) |
| Notificações | Firebase FCM | Gratuito | Sem limite de notificações |
| Analytics | Firebase | Gratuito | |
| Mapa base | Google Maps / Mapbox | Gratuito | Tier gratuito alto (SDK mobile native geralmente isento) |
| Lojas de Apps | Apple/Google | ~$125/ano | Google: $25 (único). Apple: $99/ano. |

**Custo Incremental Médio Estimado:** **Praticamente Zero** (apenas manutenção das lojas e eventual escalonamento do servidor se o tráfego explodir).

---

## 6. Métricas de Sucesso (KPIs)

O lançamento do "Prefeitura de Brazópolis" terá seu sucesso medido nos 3 primeiros meses de operação:

1. **Adoção (Downloads):** Alcançar 5.000 usuários ativos mensais (MAU) na cidade (considerando a população e uso de smartphones).
2. **Engajamento Push:** Taxa de retenção após receber alertas e CTR (Click-Through Rate) > 15% nas mensagens da Defesa Civil e Saúde.
3. **Eficiência de Protocolos:** Aumento no volume de solicitações relatadas digitalmente vs ligações (reduzir pressão nos telefones).
4. **Qualidade Técnica:**
   - Crash-Free Sessions acima de 99,5%.
   - Avaliação média nas Lojas de Aplicativos (App Store / Play Store) superior a 4,5/5 estrelas.
