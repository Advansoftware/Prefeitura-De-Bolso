# 📐 Volume 4 — Diagramas UML e Fluxos

## Projeto "Prefeitura de Brazópolis"

---

## Sumário

1. [Diagramas de Caso de Uso](#1-diagramas-de-caso-de-uso)
2. [Diagramas de Sequência](#2-diagramas-de-sequência)
3. [Diagrama de Classes (Domain)](#3-diagrama-de-classes-domain)
4. [Diagramas de Estado](#4-diagramas-de-estado)
5. [Diagramas de Atividade](#5-diagramas-de-atividade)

---

## 1. Diagramas de Caso de Uso

### 1.1 Caso de Uso Geral

```mermaid
graph LR
    subgraph "Cidadão (sem login)"
        A1["Ver avisos e notícias"]
        A2["Abrir protocolo (foto + GPS)"]
        A3["Acompanhar protocolo (código + chave)"]
        A4["Consultar IPTU"]
        A5["Ver saúde (UBS, vacinas)"]
        A6["Ver educação (calendário, merenda)"]
        A7["Ver turismo (pontos, rotas)"]
        A8["Ver eventos"]
        A9["Ver coleta de lixo"]
        A10["Ligar emergência"]
        A11["Falar via WhatsApp"]
        A12["Ver obras"]
        A13["Buscar no mapa"]
        A14["Receber notificações"]
        A15["Configurar preferências"]
    end

    subgraph "Admin (painel existente)"
        B1["Gerenciar protocolos"]
        B2["Enviar notificações"]
        B3["Gerenciar eventos"]
        B4["Gerenciar coleta"]
        B5["Atualizar status obras"]
    end

    subgraph "Sistema"
        C1["Firebase Cloud Messaging"]
        C2["MeiliSearch"]
        C3["MinIO"]
    end
```

### 1.2 Detalhamento: Protocolo

| # | Caso de Uso | Ator | Pré-condição | Fluxo principal |
|---|-------------|------|-------------|-----------------|
| UC-01 | Abrir protocolo | Cidadão | Nenhuma | Selecionar categoria → Tirar foto → Confirmar GPS → Descrição → Enviar |
| UC-02 | Acompanhar protocolo | Cidadão | Código + chave | Informar código → Validar chave → Ver timeline |
| UC-03 | Receber atualização | Cidadão | Token FCM salvo | Push automático ao mudar status |
| UC-04 | Gerenciar protocolo | Admin | Autenticado (JWT) | Ver lista → Alterar status → Observação → Salvar |

### 1.3 Detalhamento: IPTU

| # | Caso de Uso | Ator | Pré-condição | Fluxo principal |
|---|-------------|------|-------------|-----------------|
| UC-05 | Consultar débitos | Cidadão | Inscrição imobiliária | Informar inscrição → Ver parcelas → Status |
| UC-06 | Gerar boleto | Cidadão | Parcela pendente | Selecionar parcela → Gerar PDF → Download |
| UC-07 | Pagar via PIX | Cidadão | Parcela pendente | Selecionar parcela → QR Code → Copia-e-cola |
| UC-08 | Salvar favorito | Cidadão | Nenhuma | Estrela → Salvar inscrição localmente |

### 1.4 Detalhamento: Notificações

| # | Caso de Uso | Ator | Pré-condição | Fluxo principal |
|---|-------------|------|-------------|-----------------|
| UC-09 | Registrar dispositivo | Sistema | App instalado | Gerar token → Enviar ao backend → Salvar |
| UC-10 | Configurar tópicos | Cidadão | Token registrado | Toggles on/off → Atualizar tópicos |
| UC-11 | Enviar push | Admin | Autenticado | Compor mensagem → Selecionar tópico → Enviar via FCM |
| UC-12 | Receber push | Cidadão | Token válido | Notificação → Toque → Deep link para tela |

---

## 2. Diagramas de Sequência

### 2.1 Abrir Protocolo

```mermaid
sequenceDiagram
    actor Cidadão
    participant App as Flutter App
    participant Camera as Câmera/GPS
    participant API as NestJS API
    participant Storage as MinIO
    participant DB as MySQL
    participant FCM as Firebase

    Cidadão->>App: Toca "Abrir Solicitação"
    App->>App: Exibir grid de categorias
    Cidadão->>App: Seleciona "Buraco"

    App->>Camera: Abrir câmera
    Cidadão->>Camera: Tirar foto
    Camera->>App: Retorna imagem

    App->>Camera: Obter localização GPS
    Camera->>App: Retorna lat/lng
    App->>App: Geocoding reverso (endereço)
    App->>App: Exibir preview (foto + mapa + endereço)

    Cidadão->>App: Adiciona descrição (opcional)
    Cidadão->>App: Toca "Enviar"

    App->>App: Comprimir imagem (max 1MB)
    App->>API: POST /public/protocolo (multipart)
    API->>Storage: Upload foto → MinIO
    Storage-->>API: URL da foto
    API->>API: Gerar código (#5730) + chave (FT42B)
    API->>DB: INSERT protocolo
    DB-->>API: OK

    alt Cidadão ativou notificações
        App->>API: POST /public/push/register
        API->>DB: Salvar FCM token vinculado ao protocolo
    end

    API-->>App: {codigo: "5730", chave: "FT42B"}
    App->>App: Salvar em SQLite local
    App->>App: Exibir tela de confirmação
    App->>Cidadão: "Protocolo #5730 criado! Chave: FT42B"
```

### 2.2 Acompanhar Protocolo

```mermaid
sequenceDiagram
    actor Cidadão
    participant App as Flutter App
    participant API as NestJS API
    participant DB as MySQL

    alt Protocolo salvo localmente
        Cidadão->>App: Toca "Meus Protocolos"
        App->>App: Listar protocolos do SQLite
        Cidadão->>App: Seleciona protocolo #5730
    else Consulta por código
        Cidadão->>App: Toca "Consultar Protocolo"
        Cidadão->>App: Digita código "5730" + chave "FT42B"
    end

    App->>API: GET /public/protocolo/5730?chave=FT42B
    API->>DB: SELECT * FROM protocolos WHERE codigo=5730
    API->>API: Validar chave (bcrypt compare)
    DB-->>API: Dados do protocolo

    API-->>App: {status, timeline, foto, endereco}
    App->>App: Exibir timeline visual
    App->>Cidadão: Protocolo #5730 - "Equipe enviada"
```

### 2.3 Consultar IPTU

```mermaid
sequenceDiagram
    actor Cidadão
    participant App as Flutter App
    participant API as NestJS API

    Cidadão->>App: Toca card "IPTU"
    App->>App: Exibir campo de inscrição

    alt Digitar manualmente
        Cidadão->>App: Digita "01.02.003.004"
    else Escanear código de barras
        Cidadão->>App: Toca ícone de barcode
        App->>App: Abrir scanner
        App->>App: Extrair inscrição do código
    end

    App->>API: GET /public/iptu/{inscricao}
    API-->>App: {inscricao, endereco, parcelas[]}

    App->>App: Exibir lista de parcelas
    Cidadão->>App: Seleciona parcela 3

    alt Gerar Boleto
        Cidadão->>App: Toca "Gerar Boleto"
        App->>API: GET /public/iptu/{inscricao}/boleto/{parcela}
        API-->>App: PDF do boleto
        App->>App: Abrir PDF / compartilhar
    else Pagar via PIX
        Cidadão->>App: Toca "Pagar via PIX"
        App->>API: GET /public/iptu/{inscricao}/pix/{parcela}
        API-->>App: {qrCode, copiaCola, valor}
        App->>App: Exibir QR Code + botão copiar
    end
```

### 2.4 Receber Notificação Push

```mermaid
sequenceDiagram
    participant Admin as Painel Admin
    participant API as NestJS API
    participant FCM as Firebase Cloud Messaging
    participant Device as Dispositivo
    participant App as Flutter App

    Admin->>API: POST /admin/push {mensagem, topico: "saude"}
    API->>API: Buscar tokens do tópico "saude"
    API->>FCM: Enviar notificação (tópico "saude")
    FCM->>Device: Push notification

    alt App em foreground
        Device->>App: onMessage callback
        App->>App: Exibir snackbar in-app
    else App em background
        Device->>Device: Notificação no tray
        Device->>App: Cidadão toca na notificação
        App->>App: Deep link para tela de Saúde
    end
```

### 2.5 Busca Global (MeiliSearch)

```mermaid
sequenceDiagram
    actor Cidadão
    participant App as Flutter App
    participant API as NestJS API
    participant Meili as MeiliSearch

    Cidadão->>App: Digita "vacina" na barra de busca
    App->>App: Debounce 300ms
    App->>API: GET /public/search?q=vacina
    API->>Meili: search("vacina")
    Meili-->>API: Resultados indexados
    API-->>App: [{tipo: "noticia", titulo: "Vacinação..."}, {tipo: "saude", titulo: "Campanha de vacina"}]
    App->>App: Exibir resultados agrupados por tipo
    Cidadão->>App: Toca em resultado
    App->>App: Navegar para tela correspondente
```

---

## 3. Diagrama de Classes (Domain)

### 3.1 Entidades do Domínio

```mermaid
classDiagram
    class Protocol {
        +String codigo
        +String chave
        +String categoria
        +String descricao
        +double latitude
        +double longitude
        +String endereco
        +String fotoUrl
        +ProtocolStatus status
        +DateTime createdAt
        +List~ProtocolStep~ timeline
    }

    class ProtocolStep {
        +ProtocolStatus status
        +DateTime data
        +String observacao
    }

    class ProtocolStatus {
        <<enumeration>>
        RECEBIDO
        EM_ANALISE
        EQUIPE_ENVIADA
        CONCLUIDO
        CANCELADO
    }

    class Alert {
        +String titulo
        +String descricao
        +String modulo
        +DateTime createdAt
    }

    class ServiceItem {
        +String nome
        +String descricao
        +String icone
        +String categoria
        +String corCategoria
        +String rota
    }

    class HealthUnit {
        +String nome
        +String endereco
        +String telefone
        +double latitude
        +double longitude
        +String horario
        +bool abertoAgora
    }

    class TouristSpot {
        +String nome
        +String descricao
        +double distanciaKm
        +String imagemUrl
        +double latitude
        +double longitude
        +String categoria
    }

    class Event {
        +String titulo
        +String descricao
        +String categoria
        +DateTime dataInicio
        +DateTime dataFim
        +String local
        +String imagemUrl
        +bool destaque
    }

    class GarbageSchedule {
        +String bairro
        +String tipoColeta
        +List~String~ diasSemana
        +String horario
    }

    class IptuParcel {
        +int numero
        +double valor
        +DateTime vencimento
        +IptuStatus status
    }

    class IptuStatus {
        <<enumeration>>
        PAGO
        PENDENTE
        VENCIDO
    }

    Protocol --> ProtocolStatus
    Protocol --> "1..*" ProtocolStep
    ProtocolStep --> ProtocolStatus
    IptuParcel --> IptuStatus
```

---

## 4. Diagramas de Estado

### 4.1 Ciclo de Vida do Protocolo

```mermaid
stateDiagram-v2
    [*] --> Recebido: Cidadão envia
    Recebido --> EmAnalise: Admin abre
    EmAnalise --> EquipeEnviada: Admin despacha
    EquipeEnviada --> Concluido: Equipe resolve
    EmAnalise --> Cancelado: Admin cancela
    Recebido --> Cancelado: Spam / inválido

    Recebido: 📩 Protocolo criado
    EmAnalise: 🔍 Em análise pela secretaria
    EquipeEnviada: 🚚 Equipe no local
    Concluido: ✅ Problema resolvido
    Cancelado: ❌ Cancelado / inválido

    note right of Recebido: Push: "Protocolo recebido"
    note right of EmAnalise: Push: "Em análise"
    note right of EquipeEnviada: Push: "Equipe enviada"
    note right of Concluido: Push: "Resolvido! Avalie"
```

### 4.2 Ciclo de Navegação do App

```mermaid
stateDiagram-v2
    [*] --> Splash
    Splash --> Onboarding: Primeira vez
    Splash --> Home: Retorno
    Onboarding --> Home: Completou/Pulou

    state Shell {
        Home --> Modulo: Card de serviço
        Home --> Emergencia: FAB
        Modulo --> Home: Voltar
        Emergencia --> Home: Fechar modal

        Home --> Mapa: Bottom Nav
        Mapa --> Home: Bottom Nav

        Home --> Protocolos: Bottom Nav
        Protocolos --> Home: Bottom Nav

        Home --> WhatsApp: Bottom Nav
        WhatsApp --> Home: Retorno do WhatsApp

        Home --> Menu: Bottom Nav
        Menu --> Home: Bottom Nav
    }
```

---

## 5. Diagramas de Atividade

### 5.1 Fluxo de Abertura do App

```mermaid
flowchart TD
    A[App aberto] --> B{Primeira vez?}
    B -->|Sim| C[Exibir Onboarding]
    C --> D{Permissão de push?}
    D -->|Aceitar| E[Registrar FCM token]
    D -->|Recusar| F[Pular]
    E --> G[Ir para Home]
    F --> G

    B -->|Não| H{Cache válido?}
    H -->|Sim| I[Carregar Home do cache]
    H -->|Não| J{Online?}
    J -->|Sim| K[Buscar dados da API]
    J -->|Não| L[Carregar último cache]

    I --> G
    K --> G
    L --> M[Exibir banner offline]
    M --> G
```

### 5.2 Fluxo de Abertura de Protocolo

```mermaid
flowchart TD
    A[Tela de Categorias] --> B[Selecionar categoria]
    B --> C{Permissão de câmera?}
    C -->|Sim| D[Abrir câmera]
    C -->|Não| E[Solicitar permissão]
    E -->|Concedida| D
    E -->|Negada| F[Exibir mensagem de erro]

    D --> G[Tirar foto]
    G --> H{Permissão GPS?}
    H -->|Sim| I[Obter localização]
    H -->|Não| J[Solicitar permissão]
    J -->|Concedida| I
    J -->|Negada| K[Digitar endereço manualmente]

    I --> L[Exibir preview]
    K --> L
    L --> M[Adicionar descrição - opcional]
    M --> N{Online?}
    N -->|Sim| O[Enviar ao servidor]
    N -->|Não| P[Salvar rascunho local]

    O --> Q{Sucesso?}
    Q -->|Sim| R[Exibir código + chave]
    Q -->|Não| S[Exibir erro + retry]

    R --> T{Ativar notificações?}
    T -->|Sim| U[Vincular FCM ao protocolo]
    T -->|Não| V[Salvar localmente apenas]
    U --> V
```

### 5.3 Fluxo de WhatsApp

```mermaid
flowchart TD
    A[Toca WhatsApp na Bottom Nav] --> B[Exibir tela de contato]
    B --> C{Setor específico?}
    C -->|Sim| D[Selecionar setor]
    C -->|Não| E[Número geral]
    D --> F[Montar URL wa.me com número do setor]
    E --> G[Montar URL wa.me com número geral]
    F --> H[Mensagem pré-formatada]
    G --> H
    H --> I[Abrir WhatsApp via URL Scheme]
    I --> J{WhatsApp instalado?}
    J -->|Sim| K[Abre conversa]
    J -->|Não| L[Abrir wa.me no navegador]
```

---

> **Nota:** Todos os diagramas usam Mermaid para renderização. Em implementação, os diagramas de sequência servem como guia para criação dos testes de integração.
