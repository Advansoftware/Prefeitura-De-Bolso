<![CDATA[# 🧪 Volume 7 — Plano de Testes e Qualidade

## Projeto "Prefeitura no Bolso"

---

## Sumário

1. [Padrões de Qualidade Frontend (Flutter)](#1-padrões-de-qualidade-frontend-flutter)
2. [Padrões de Qualidade Backend (NestJS)](#2-padrões-de-qualidade-backend-nestjs)
3. [Estratégia de Testes Automatizados](#3-estratégia-de-testes-automatizados)
4. [Testes Manuais (QA)](#4-testes-manuais-qa)
5. [Linting e Code Analysis](#5-linting-e-code-analysis)
6. [Monitoramento Pós-Lançamento](#6-monitoramento-pós-lançamento)

---

## 1. Padrões de Qualidade Frontend (Flutter)

A arquitetura do app seguirá a **Clean Architecture**, exigindo disciplina rigorosa de separação de responsabilidades.

### 1.1 Regras de Código (Semelhantes ao `.antigravity/rules/06-qualidade-frontend.md`)
- **Tamanho dos arquivos:** Nenhum arquivo Dart deve ultrapassar ~250-300 linhas.
- **Componentização:** Se um Widget fica longo, extrair métodos de `build()` para novas classes StatelessWidgets independentes.
- **No "God Classes":** Nada de Cubits gigantescos com múltiplas responsabilidades.
- **Tipagem Forte:** Proibido o uso de `dynamic` ou `var` onde o tipo pode ser inferido ou explicitado. Strict type checking habilitado no `analysis_options.yaml`.
- **Separação UI/Regra:** Nenhuma lógica de negócio, chamadas HTTP ou parseamento de JSON permitidos dentro de Widgets ou de `build()`. Tudo delegar para BLoC/Cubit e Repositories.

---

## 2. Padrões de Qualidade Backend (NestJS)

O backend já existe e deve manter seu padrão alto de qualidade:
- Strict TypeScript sem `any`.
- DTOs validados via `class-validator` e `class-transformer`.
- Cobertura de testes unitários para Services novos.
- Swagger decorators em todos os controllers para autogeração de documentação.

---

## 3. Estratégia de Testes Automatizados

### 3.1 Flutter Unit Tests (Lógica)
Testes focados em BLoCs, Cubits, UseCases, Repositories e Models.
- **Ferramentas:** `test`, `mocktail` ou `mockito`.
- **Casos:**
  - Mockar o Repository, disparar métodos no Cubit e garantir que o fluxo de estados é emitido corretamente (Loading -> Success ou Loading -> Error).
  - Testar `fromJson()` e `toJson()` dos modelos.

### 3.2 Flutter Widget Tests (UI)
Testes que montam partes da tela em memória para checar renderização e interações.
- **Ferramentas:** `flutter_test`.
- **Casos:**
  - Injetar um estado "Success" no Cubit mockado e verificar se a lista de elementos é exibida.
  - Simular toque num botão e garantir que a callback é chamada.
  - Testar o comportamento do botão "Salvar Favorito" e mudanças de estado visual.

### 3.3 Flutter Integration Tests (E2E)
Testes rodando em emuladores ou devices reais.
- **Ferramentas:** `integration_test` e Patrol (recomendado).
- **Casos Principais (Critical Paths):**
  - **E2E 01 (Protocolo):** Abrir app → Aba Protocolos → Criar → Mock de câmera → Mock de GPS → Submeter → Ver código gerado.
  - **E2E 02 (IPTU):** Abrir app → Card IPTU → Digitar mock de inscrição → Visualizar parcelas → Tocar Gerar PIX.

### 3.4 Backend NestJS Tests
- **Unitários:** Usando `Jest`. Testar as lógicas dos novos Services (Protocolo, Push).
- **e2e (End-to-end):** Com `Supertest` rodando sobre um banco de testes (SQLite em memória ou contêiner de teste do MySQL), validando endpoints, schemas de resposta HTTP e rate-limiting.

---

## 4. Testes Manuais (QA)

Antes de cada release nas lojas, a equipe deve seguir uma matriz de teste:

| Módulo | Plataforma | Carga (Condição) | Esperado | Status |
|--------|------------|------------------|----------|--------|
| **Home** | iOS / Android | Com e sem internet | Banners em cache se offline, carregamento rápido | [ ] |
| **Protocolo** | iOS / Android | Permissões revogadas | App deve pedir permissão novamente com explicação amigável | [ ] |
| **Notificações**| iOS / Android | App em background (fechado) | Push chega com som, click abre o deeplink certo | [ ] |
| **Mapa** | iOS / Android | Baixa velocidade (3G) | Mapa carrega tiles, pins renderizam corretamente | [ ] |
| **IPTU** | iOS / Android | Payload grande | Lista renderiza sem lag (smooth scrolling 60fps) | [ ] |

---

## 5. Linting e Code Analysis

### 5.1 Flutter
O projeto usará um pacote rigoroso de linting, como `flutter_lints` ou `very_good_analysis`.

**Regras estritas no `analysis_options.yaml`:**
- `avoid_dynamic_calls`
- `always_declare_return_types`
- `prefer_single_quotes`
- `require_trailing_commas`
- `sort_constructors_first`
- CI/CD (GitHub Actions) deve quebrar o build se o `flutter analyze` reportar avisos ou erros.

### 5.2 NestJS
- `eslint` com parser TypeScript. Proibir `any`, variáveis não usadas, retornos implícitos e garantir o padrão de estilo da base existente.

---

## 6. Monitoramento Pós-Lançamento

A qualidade se mantém após o deploy com ferramentas de telemetria:

### 6.1 Crash Reporting
- **Firebase Crashlytics:** Monitorar crashes fatais e non-fatals (exceções pegadas).
- **Alertas:** Slack/Discord webhook caso o Crash-Free Sessions caia abaixo de 99%.

### 6.2 Performance (APM)
- **Firebase Performance Monitoring:**
  - Medir Tempo de início (App Startup).
  - Medir latência de rede (Duração média dos endpoints `/public/protocolo`).
  - Monitorar 'Slow rendering' (frames perdidos).

### 6.3 Analytics (Anônimo)
- **Firebase Analytics:**
  - Quais módulos são mais clicados (Eventos personalizados: `select_module`, parameter: `module_name`).
  - Funil de protocolos (`open_camera`, `take_photo`, `submit_success`).
]]>
