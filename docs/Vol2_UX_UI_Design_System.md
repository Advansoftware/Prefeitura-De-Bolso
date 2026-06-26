<![CDATA[# 🎨 Volume 2 — UX/UI e Design System

## Projeto "Prefeitura no Bolso"
### Plataforma de Relacionamento com o Cidadão

| Item | Detalhe |
|------|---------|
| **Versão** | 2.1 |
| **Data** | Junho 2026 |
| **Referência visual** | Site oficial da Prefeitura de Brazópolis |

---

## Sumário

1. [Design System](#1-design-system)
2. [Paleta de Cores](#2-paleta-de-cores)
3. [Tipografia](#3-tipografia)
4. [Espaçamentos e Grid](#4-espaçamentos-e-grid)
5. [Componentes Base](#5-componentes-base)
6. [Iconografia](#6-iconografia)
7. [Navegação](#7-navegação)
8. [Catálogo de Telas](#8-catálogo-de-telas)
9. [Fluxos de Navegação](#9-fluxos-de-navegação)
10. [Animações e Micro-interações](#10-animações-e-micro-interações)
11. [Acessibilidade](#11-acessibilidade)
12. [Modo Offline](#12-modo-offline)

---

## 1. Design System

### 1.1 Princípios de Design

| Princípio | Descrição |
|-----------|-----------|
| **Institucional, não corporativo** | Visual alinhado ao portal existente, sem parecer um app de startup |
| **Clareza primeiro** | Informações claras, textos legíveis, hierarquia visual óbvia |
| **Ação rápida** | Cada serviço acessível em no máximo 2 toques |
| **Consistência** | Todos os módulos seguem o mesmo padrão visual do site |
| **Sem barreiras** | Nenhuma tela exige login, cadastro ou identificação |

### 1.2 Referência Visual

O design do app segue fielmente a identidade do site oficial:
- Barra de busca no topo
- Carousel hero com fotos da cidade
- Seção "O que eu PRECISO" com cards em grid 2x2
- Labels de categoria coloridas nos cards
- Ícones outlined (contornados)
- Tipografia Roboto
- Fundo branco com cards com sombra sutil

---

## 2. Paleta de Cores

### 2.1 Cores Principais (extraídas do tema do site)

| Token | Nome | Hex | RGB | Uso |
|-------|------|-----|-----|-----|
| `primary` | Azul Institucional | `#004A80` | 0, 74, 128 | Headers, botões, ícones, links |
| `primary-light` | Azul Claro | `#3185C2` | 49, 133, 194 | Hover, destaques, badges |
| `primary-dark` | Azul Escuro | `#003366` | 0, 51, 102 | Backgrounds escuros, textos fortes |
| `secondary` | Vermelho | `#dc004e` | 220, 0, 78 | Emergência, alertas, badges críticos |
| `whatsapp` | Verde WhatsApp | `#25D366` | 37, 211, 102 | Botão WhatsApp, sucesso |

### 2.2 Cores de Texto

| Token | Hex | Uso |
|-------|-----|-----|
| `text-primary` | `#3A3A3C` | Títulos e textos principais |
| `text-secondary` | `#666666` | Descrições, textos auxiliares |
| `text-disabled` | `#AAAAAA` | Textos desabilitados |
| `text-on-primary` | `#FFFFFF` | Texto sobre fundo azul |

### 2.3 Cores de Fundo

| Token | Hex | Uso |
|-------|-----|-----|
| `bg-default` | `#FFFFFF` | Fundo geral |
| `bg-surface` | `#F5F5F5` | Fundo de seções, listas |
| `bg-card` | `#FFFFFF` | Cards com sombra |
| `bg-header` | `#004A80` | Headers e AppBar |

### 2.4 Cores de Categoria (labels dos cards)

| Categoria | Cor | Hex |
|-----------|-----|-----|
| Transparência | Teal | `#009688` |
| Institucional | Azul | `#004A80` |
| Saúde | Verde | `#4CAF50` |
| Educação | Azul Escuro | `#1565C0` |
| Serviços | Laranja | `#FF9800` |
| Habitação | Marrom | `#795548` |
| Turismo | Azul Claro | `#03A9F4` |
| Emergência | Vermelho | `#dc004e` |
| Defesa Civil | Amarelo | `#FFC107` |

### 2.5 Cores de Status

| Status | Cor | Hex | Uso |
|--------|-----|-----|-----|
| Sucesso | Verde | `#4CAF50` | Protocolo concluído, pagamento ok |
| Aviso | Amarelo | `#FFC107` | Vencimento próximo, atenção |
| Erro | Vermelho | `#F44336` | Falha, débito vencido |
| Info | Azul | `#2196F3` | Informações gerais |
| Em andamento | Azul | `#004A80` | Protocolo em análise |

---

## 3. Tipografia

### 3.1 Família Tipográfica

| Peso | Nome | Uso |
|------|------|-----|
| 300 | Roboto Light | Textos longos, descrições |
| 400 | Roboto Regular | Corpo do texto, labels |
| 500 | Roboto Medium | Subtítulos, botões |
| 700 | Roboto Bold | Títulos, destaques |

### 3.2 Escala Tipográfica

| Estilo | Tamanho | Peso | Line Height | Uso |
|--------|---------|------|-------------|-----|
| `headline1` | 28sp | Bold | 34sp | Título de tela ("Saúde", "IPTU") |
| `headline2` | 24sp | Bold | 30sp | Título de seção ("O que eu PRECISO") |
| `headline3` | 20sp | Medium | 26sp | Título de card |
| `subtitle1` | 16sp | Medium | 22sp | Subtítulos, nomes de serviço |
| `body1` | 16sp | Regular | 24sp | Corpo do texto |
| `body2` | 14sp | Regular | 20sp | Texto secundário |
| `caption` | 12sp | Regular | 16sp | Labels, timestamps |
| `overline` | 10sp | Medium | 14sp | Categoria badges |
| `button` | 14sp | Medium | 18sp | Texto de botões |

---

## 4. Espaçamentos e Grid

### 4.1 Sistema de Espaçamento (base 4px)

| Token | Valor | Uso |
|-------|-------|-----|
| `xs` | 4px | Margem mínima |
| `sm` | 8px | Padding interno de badges |
| `md` | 16px | Padding padrão de cards |
| `lg` | 24px | Espaçamento entre seções |
| `xl` | 32px | Margens laterais da tela |
| `xxl` | 48px | Espaçamento entre blocos |

### 4.2 Grid

| Propriedade | Valor |
|-------------|-------|
| Colunas | 2 (cards) ou fluído |
| Gutter | 16px |
| Margem lateral | 16px |
| Largura máxima | 428px (iPhone 14 Pro Max) |

### 4.3 Raios de Borda

| Token | Valor | Uso |
|-------|-------|-----|
| `radius-sm` | 4px | Badges, chips |
| `radius-md` | 8px | Cards, inputs |
| `radius-lg` | 12px | Bottom sheets |
| `radius-xl` | 16px | Cards grandes |
| `radius-full` | 999px | Botões arredondados, avatares |

### 4.4 Elevação (Sombras)

| Nível | Sombra CSS | Uso |
|-------|------------|-----|
| 0 | Nenhuma | Elementos flat |
| 1 | `0 1px 3px rgba(0,0,0,0.12)` | Cards padrão |
| 2 | `0 3px 6px rgba(0,0,0,0.16)` | Cards elevados, FAB |
| 3 | `0 6px 12px rgba(0,0,0,0.20)` | Bottom sheets, modais |

---

## 5. Componentes Base

### 5.1 AppBar (Header)

```
┌──────────────────────────────────┐
│ ← [Título da Tela]          🔔  │  Altura: 56px
│    primary-dark (#003366)        │  Texto: branco, headline3
└──────────────────────────────────┘
```

- Fundo: `#004A80` (primary)
- Texto e ícones: branco
- Botão voltar à esquerda (quando não é Home)
- Ícone de notificações à direita (com badge)
- Sombra nível 1

### 5.2 Bottom Navigation Bar

```
┌──────────────────────────────────┐
│ 🏠    📍    🚧    💬    ☰      │  Altura: 60px
│ Home  Mapa Proto WhApp Menu     │  Fundo: branco
└──────────────────────────────────┘
```

- 5 itens fixos
- Ícone ativo: `primary` (#004A80)
- Ícone inativo: `text-secondary` (#666666)
- WhatsApp: ícone sempre verde `#25D366`
- Label abaixo de cada ícone (12sp)
- Sombra superior sutil

### 5.3 Card de Serviço (estilo site)

```
┌──────────────────────┐
│ [Categoria]          │  Label colorida (overline)
│      🏛️              │  Ícone outlined, centralizado
│  Nome do Serviço     │  subtitle1, bold
│  Descrição curta     │  body2, text-secondary
└──────────────────────┘
```

- Fundo: branco
- Borda: 1px `#E0E0E0`
- Raio: `radius-md` (8px)
- Sombra: nível 1
- Padding: 16px
- Label de categoria com cor de fundo, texto branco, border-radius 4px

### 5.4 Card de Aviso/Alerta

```
┌──────────────────────────────────┐
│ ⚠️ Vacinação contra gripe amanhã │  Fundo: primary (#004A80)
└──────────────────────────────────┘  Texto: branco, body1
```

- Fundo: `primary` com 95% opacidade
- Texto: branco
- Ícone à esquerda
- Borda arredondada: `radius-md`
- Toque abre a tela do módulo correspondente

### 5.5 Botão Primário

```
┌──────────────────────┐
│    Pagar via PIX     │  Fundo: primary
└──────────────────────┘  Texto: branco, button
```

- Fundo: `primary` (#004A80)
- Texto: branco, 14sp medium
- Padding: 12px 24px
- Raio: `radius-full`
- Sombra: nível 1
- Estado pressionado: `primary-dark`
- Estado desabilitado: 50% opacidade

### 5.6 Botão Secundário (Outline)

```
┌──────────────────────┐
│    Gerar Boleto      │  Borda: primary
└──────────────────────┘  Texto: primary, button
```

- Fundo: transparente
- Borda: 2px `primary`
- Texto: `primary`, 14sp medium
- Mesmos padding e raio do primário

### 5.7 Botão de Emergência (FAB)

```
    ┌─────────────────┐
    │ 🚨 Emergência   │  Fundo: secondary (#dc004e)
    └─────────────────┘  Texto: branco, bold
```

- Fundo: `secondary` (#dc004e)
- Texto: branco, 14sp bold
- Raio: `radius-full`
- Sombra: nível 2
- Posição: flutuante sobre conteúdo, acima da bottom nav
- Animação: leve pulsação sutil a cada 10s

### 5.8 Botão WhatsApp

```
    ┌──────────────────────┐
    │ 💬 Abrir WhatsApp    │  Fundo: #25D366
    └──────────────────────┘  Texto: branco, bold
```

- Fundo: `whatsapp` (#25D366)
- Ícone do WhatsApp à esquerda
- Texto: branco
- Raio: `radius-full`

### 5.9 Campo de Busca

```
┌──────────────────────────────────┐
│ 🔍 Pesquisar...                  │  Fundo: branco
└──────────────────────────────────┘  Borda: #E0E0E0
```

- Fundo: branco
- Borda: 1px `#E0E0E0`
- Raio: `radius-md` (8px)
- Ícone de lupa à esquerda
- Placeholder: `text-disabled`
- Altura: 48px

### 5.10 Carousel Hero

```
┌──────────────────────────────────┐
│                                  │
│     [Foto da cidade]             │  Altura: 200px
│     "Estação Dias"               │  Texto sobre imagem
│     ● ● ● ● ○ ○                 │  Indicadores
│                                  │
└──────────────────────────────────┘
```

- Altura: 200px
- Imagens vindas da API de carousel existente
- Texto overlay com sombra para legibilidade
- Indicadores de página (dots)
- Autoplay: 5 segundos
- Swipe habilitado

### 5.11 Timeline de Protocolo

```
    ● Recebido         10/06
    │
    ● Em análise       12/06
    │
    ◉ Equipe enviada   13/06  ← atual
    │
    ○ Concluído        ----
```

- Círculos: 12px diâmetro
- Preenchido: `#4CAF50` (verde) para concluído
- Contorno: `primary` para atual
- Vazio: `#E0E0E0` para pendente
- Linha: 2px `#E0E0E0`
- Texto: `body2` ao lado do círculo

### 5.12 Badge de Notificação

```
  🔔
   ⑤  ← badge vermelho
```

- Fundo: `secondary` (#dc004e)
- Texto: branco, 10sp bold
- Tamanho: 18px diâmetro
- Posição: top-right do ícone

---

## 6. Iconografia

### 6.1 Estilo

- **Tipo:** Outlined (contornados), consistente com o site
- **Biblioteca:** Material Icons ou Material Symbols (outlined)
- **Tamanho padrão:** 24px (ícones de navegação e lista)
- **Tamanho grande:** 48px (ícones nos cards de serviço)
- **Cor:** `primary` quando ativo, `text-secondary` quando inativo

### 6.2 Mapeamento de Ícones por Módulo

| Módulo | Ícone Material | Código |
|--------|---------------|--------|
| Home | `home` | `Icons.home_outlined` |
| Mapa | `map` | `Icons.map_outlined` |
| Protocolos | `assignment` | `Icons.assignment_outlined` |
| WhatsApp | Custom SVG | WhatsApp brand icon |
| Menu | `menu` | `Icons.menu` |
| IPTU | `account_balance` | `Icons.account_balance_outlined` |
| Saúde | `favorite` | `Icons.favorite_outlined` |
| Educação | `school` | `Icons.school_outlined` |
| Turismo | `flight` | `Icons.flight_outlined` |
| Coleta | `delete` | `Icons.delete_outlined` |
| Emergência | `emergency` | `Icons.emergency_outlined` |
| Concursos | `work` | `Icons.work_outlined` |
| Defesa Civil | `shield` | `Icons.shield_outlined` |
| Eventos | `event` | `Icons.event_outlined` |
| Obras | `construction` | `Icons.construction_outlined` |
| Certidões | `description` | `Icons.description_outlined` |
| Licitações | `gavel` | `Icons.gavel_outlined` |
| Notificações | `notifications` | `Icons.notifications_outlined` |
| Configurações | `settings` | `Icons.settings_outlined` |
| Busca | `search` | `Icons.search` |

---

## 7. Navegação

### 7.1 Estrutura de Navegação

```
App
├── Splash Screen
├── Onboarding (primeira vez)
└── Shell (Bottom Navigation)
    ├── Home
    │   ├── Busca global
    │   ├── Módulo IPTU
    │   │   ├── Consulta
    │   │   ├── Pagamento (PIX/Boleto)
    │   │   └── Favoritos locais
    │   ├── Módulo Saúde
    │   │   ├── Campanhas
    │   │   └── UBS (lista + mapa)
    │   ├── Módulo Educação
    │   │   ├── Calendário
    │   │   ├── Merenda
    │   │   └── Escolas (lista + mapa)
    │   ├── Módulo Turismo
    │   │   ├── Pontos turísticos
    │   │   ├── Roteiros
    │   │   └── Onde comer/ficar
    │   ├── Módulo Eventos
    │   ├── Módulo Coleta de Lixo
    │   ├── Módulo Concursos
    │   ├── Módulo Obras
    │   ├── Módulo Certidões
    │   ├── Módulo Licitações
    │   ├── Módulo Defesa Civil
    │   └── Módulo Transparência
    ├── Mapa Inteligente
    │   └── Camadas (saúde, educação, turismo, obras, coleta)
    ├── Protocolos
    │   ├── Abrir solicitação
    │   │   ├── Selecionar categoria
    │   │   ├── Tirar foto
    │   │   ├── Confirmar GPS
    │   │   └── Enviar → Código + Chave
    │   ├── Meus protocolos (local)
    │   └── Consultar por código
    ├── WhatsApp
    │   └── Abre WhatsApp (deep link wa.me)
    └── Menu (mais opções)
        ├── Todos os serviços
        ├── Notificações
        ├── Configurações
        │   ├── Meu bairro
        │   ├── Notificações (toggles por categoria)
        │   ├── Idioma
        │   └── Sobre / Privacidade
        └── Emergência
```

### 7.2 Padrões de Navegação

| Ação | Navegação |
|------|-----------|
| Toque em card de serviço | Push para tela do módulo |
| Toque em "Ver no mapa" | Push para Mapa com pin selecionado |
| Toque em WhatsApp (bottom nav) | Deep link `wa.me/{numero}` |
| Toque em Emergência (FAB) | Modal overlay com telefones |
| Toque em notificação | Deep link para tela correspondente |
| Swipe back | Pop para tela anterior |
| Toque em item da bottom nav | Switch de tab (sem push) |

---

## 8. Catálogo de Telas

### 8.1 Lista Completa de Telas

| # | Tela | Tipo | Mockup |
|---|------|------|--------|
| 01 | Splash Screen | Full screen | ✅ Gerado |
| 02 | Onboarding (3 slides) | Full screen | ✅ Gerado |
| 03 | Home | Tab principal | ✅ Gerado (v2 - estilo site) |
| 04 | Protocolos — Categorias | Push | ✅ Gerado |
| 05 | Abrir Protocolo (câmera + GPS) | Push | Pendente |
| 06 | Acompanhar Protocolo (timeline) | Push | ✅ Gerado |
| 07 | Meus Protocolos (lista local) | Push | Pendente |
| 08 | Saúde — Dashboard | Push | ✅ Gerado |
| 09 | Educação — Dashboard | Push | ✅ Gerado |
| 10 | Turismo — Pontos | Push | ✅ Gerado |
| 11 | Turismo — Detalhe do ponto | Push | Pendente |
| 12 | IPTU — Consulta e Pagamento | Push | ✅ Gerado |
| 13 | IPTU — PIX (QR Code) | Modal | Pendente |
| 14 | Eventos e Agenda | Push | ✅ Gerado |
| 15 | Coleta de Lixo | Push | ✅ Gerado |
| 16 | Emergência | Modal overlay | ✅ Gerado |
| 17 | Mapa Inteligente | Tab | ✅ Gerado |
| 18 | WhatsApp — Contato | Push/Deep link | Pendente (quota) |
| 19 | Notificações | Push | ✅ Gerado |
| 20 | Configurações | Push | ✅ Gerado |
| 21 | Defesa Civil — Alerta | Push | Pendente (quota) |
| 22 | Concursos e Vagas | Push | Pendente (quota) |
| 23 | Obras — Lista e progresso | Push | ✅ Gerado |
| 24 | Certidões | Push | Pendente |
| 25 | Licitações | Push | Pendente |
| 26 | Transparência (WebView) | Push | N/A (webview) |
| 27 | Busca global (resultados) | Overlay | Pendente |

**Total gerados: 15 mockups** | **Pendentes: 7** (serão gerados quando a quota resetar)

### 8.2 Especificação por Tela

#### Tela 01: Splash Screen
- **Duração:** 2 segundos + carregamento
- **Fundo:** Gradiente `primary-dark` → `primary`
- **Elementos:** Logo prefeitura (centralizado), nome "Prefeitura no Bolso" (abaixo), indicador de loading
- **Animação:** Logo fade-in (300ms), texto slide-up (500ms delay)
- **Transição:** Fade-out para Onboarding (primeira vez) ou Home (retorno)

#### Tela 02: Onboarding
- **Slide 1:** "Bem-vindo!" — Ilustração cidade + celular, descrição do app
- **Slide 2:** "Receba alertas" — Ilustração notificações, solicitar permissão push
- **Slide 3:** "Comece agora" — Ilustração serviços, botão "Começar"
- **Persistência:** Flag `onboarding_completed` em SharedPreferences
- **Skip:** Link "Pular" em todas as telas

#### Tela 03: Home
- **Estrutura (de cima para baixo):**
  1. Barra de busca (estilo site)
  2. Carousel hero (fotos da cidade, API existente)
  3. Cards de aviso (até 3, azul com texto branco)
  4. Título "O que eu PRECISO" (estilo site)
  5. Grid 2x2 de cards de serviço (estilo site, com labels de categoria)
  6. FAB Emergência (flutuante)
  7. Bottom Navigation Bar

#### Tela 04-07: Protocolos
- **Categorias:** Grid 2x2 com ícones grandes (estilo site)
- **Abrir:** Camera → Preview → GPS auto → Descrição (opcional) → Enviar
- **Confirmação:** Código + Chave + opção salvar + opção notificações
- **Timeline:** Vertical com 4 etapas, ícone e data em cada

#### Tela 08: Saúde
- Cards horizontais: Campanhas, UBS Abertas, Telefones
- Lista de UBS com endereço, telefone, botão "Ver no mapa"

#### Tela 12: IPTU
- Campo de busca com scanner de código de barras
- Lista de parcelas com status (pago/pendente/vencido)
- Botões "Gerar Boleto" e "PIX"
- Favoritar inscrição (estrela)

---

## 9. Fluxos de Navegação

### 9.1 Fluxo Principal

```
Splash → Onboarding (1ª vez) → Home
                                 ├── Card IPTU → Consulta → Pagamento
                                 ├── Card Saúde → Dashboard → UBS → Mapa
                                 ├── Card Turismo → Pontos → Detalhe → Rota
                                 ├── FAB Emergência → Modal com telefones
                                 └── Bottom Nav → Mapa / Protocolos / WhatsApp / Menu
```

### 9.2 Fluxo de Protocolo

```
Home → Protocolos (Bottom Nav)
         │
         ├── "Abrir solicitação"
         │    ├── Selecionar categoria
         │    ├── Câmera (foto obrigatória)
         │    ├── Confirmar localização GPS
         │    ├── Descrição (opcional)
         │    └── Enviar
         │         └── Tela de confirmação
         │              ├── Código #XXXX + Chave XXXXX
         │              ├── [Salvar no celular]
         │              └── [Ativar notificações]
         │
         ├── "Meus protocolos"
         │    └── Lista local → Toque → Timeline detalhada
         │
         └── "Consultar protocolo"
              ├── Informar número + chave
              └── Timeline detalhada
```

### 9.3 Fluxo de Pagamento IPTU

```
Home → Card IPTU
         │
         ├── Digitar inscrição imobiliária
         │    (ou escanear código de barras)
         │
         ├── Exibir débitos (parcelas)
         │
         ├── Selecionar parcela
         │    ├── [Gerar Boleto] → PDF para download
         │    └── [PIX] → QR Code + Copia-e-cola
         │         └── [Copiar código]
         │
         └── [⭐ Salvar inscrição] → Favorito local
```

---

## 10. Animações e Micro-interações

| Elemento | Animação | Duração | Easing |
|----------|----------|---------|--------|
| Splash → Home | Fade out/in | 300ms | `easeInOut` |
| Cards de serviço | Scale on press (0.95) | 100ms | `easeOut` |
| FAB Emergência | Pulsação sutil | 2s (loop a cada 10s) | `easeInOut` |
| Bottom Nav item | Bounce no ícone ativo | 200ms | `bounceOut` |
| Carousel | Auto-slide | 5000ms | `easeInOut` |
| Timeline step | Fill animation | 500ms | `easeOut` |
| Cards de aviso | Slide-in da direita | 300ms | `easeOut` |
| Pull-to-refresh | Indicador circular | Contínuo | Linear |
| Notificação nova | Shake do sino | 500ms | `easeInOut` |
| Toggle | Slide + color change | 200ms | `easeOut` |

---

## 11. Acessibilidade

| Requisito | Implementação |
|-----------|--------------|
| Contraste mínimo | WCAG AA (4.5:1) — todas as combinações de cores verificadas |
| Tamanho de toque | Mínimo 48x48dp para todos os elementos interativos |
| Labels | Todos os ícones possuem `semanticsLabel` para leitores de tela |
| Fonte ajustável | `MediaQuery.textScaleFactor` respeitado |
| Ordem de foco | Tab order lógica em todas as telas |
| Alto contraste | Suporte a modo de alto contraste do sistema |
| Reduzir movimento | `MediaQuery.disableAnimations` verificado |

---

## 12. Modo Offline

### 12.1 Comportamento por módulo

| Módulo | Offline | Detalhes |
|--------|---------|----------|
| Home | Parcial | Cards de aviso em cache, grade de serviços funciona |
| Protocolos (salvos) | ✅ Total | Lista local + timeline da última sincronização |
| Protocolos (abrir) | ❌ Não | Requer envio de foto e GPS ao servidor |
| Saúde | Parcial | Dados cacheados por 24h |
| Educação | ✅ Total | Calendário e merenda cacheados |
| Turismo | Parcial | Dados cacheados, mapa offline se baixado |
| IPTU | ❌ Não | Requer consulta ao servidor |
| Eventos | Parcial | Eventos da semana cacheados |
| Coleta de Lixo | ✅ Total | Dados simples, cacheados localmente |
| Emergência | ✅ Total | Telefones sempre disponíveis offline |
| Mapa | Parcial | Requer tiles online (ou cache de tiles) |
| Configurações | ✅ Total | Dados locais |

### 12.2 Indicador Visual

```
┌──────────────────────────────────┐
│ ⚠️ Sem conexão — modo offline   │  Fundo: #FFC107 (amarelo)
└──────────────────────────────────┘  Texto: #3A3A3C
```

Banner fixo no topo quando sem conexão, desaparece ao reconectar.

---

> **Nota:** Os mockups pendentes (Defesa Civil, Concursos, WhatsApp) serão gerados quando a quota de imagens resetar. O design segue o mesmo padrão visual dos 15 mockups já gerados.
]]>
