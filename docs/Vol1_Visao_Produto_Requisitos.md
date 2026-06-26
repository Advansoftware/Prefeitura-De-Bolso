# 📘 Volume 1 — Visão do Produto e Requisitos

## Projeto "Prefeitura de Brazópolis"
### Plataforma de Relacionamento com o Cidadão

| Item | Detalhe |
|------|---------|
| **Versão** | 2.1 |
| **Data** | Junho 2026 |
| **Classificação** | Confidencial — Uso para apresentação comercial e planejamento |
| **Premissa** | App 100% aberto, sem login, sem cadastro, sem perfil de usuário |
| **Município de referência** | Brazópolis – MG |
| **Backend existente** | NestJS 10 + MySQL + MeiliSearch + Minio |
| **Paleta de cores** | Primary: #004A80, Secondary: #dc004e, WhatsApp: #25D366 |

---

## Sumário

1. [Visão Geral do Projeto](#1-visão-geral-do-projeto)
2. [Objetivos Estratégicos](#2-objetivos-estratégicos)
3. [Diagnóstico do Portal Atual](#3-diagnóstico-do-portal-atual)
4. [Solução Proposta](#4-solução-proposta)
5. [Públicos-Alvo](#5-públicos-alvo)
6. [Requisitos Funcionais](#6-requisitos-funcionais)
7. [Requisitos Não-Funcionais](#7-requisitos-não-funcionais)
8. [Jornadas do Usuário](#8-jornadas-do-usuário)
9. [Wireframes Descritivos](#9-wireframes-descritivos)
10. [Matriz de Funcionalidades por Perfil](#10-matriz-de-funcionalidades-por-perfil)
11. [Considerações LGPD e Privacidade](#11-considerações-lgpd-e-privacidade)
12. [Glossário](#12-glossário)
13. [Referências](#13-referências)

---

## 1. Visão Geral do Projeto

### 1.1 O que é o "Prefeitura de Brazópolis"?

O **"Prefeitura de Brazópolis"** é uma plataforma digital de relacionamento entre a administração municipal e seus públicos — cidadãos, turistas, empresários, servidores públicos e produtores rurais. Diferentemente do portal institucional — que cumpre bem o papel de consulta estática — o aplicativo foi concebido como um **hub de serviços proativos, comunicação direta e engajamento diário**.

O principal diferencial é que **o app vai até o cidadão**, por meio de notificações push, lembretes e conteúdos personalizados, em vez de esperar que ele acesse o site.

### 1.2 Princípio Fundamental: Sem Login

O aplicativo **não exige cadastro, login, senha ou qualquer identificação civil**. Qualquer pessoa pode instalar e usar imediatamente todos os serviços disponíveis. Essa decisão é alinhada ao comportamento do portal atual da prefeitura, que também não exige login.

A personalização do app é feita **localmente no dispositivo** (SharedPreferences/localStorage), e o acompanhamento de serviços como protocolos funciona com **código + chave temporária**, sem vínculo com CPF ou conta de usuário.

### 1.3 Proposta de Valor

| Para quem | Valor entregue |
|-----------|----------------|
| **Cidadão** | Serviços públicos na palma da mão, sem filas, sem burocracia |
| **Turista** | Descobrir a cidade com roteiros inteligentes e informações por proximidade |
| **Empresário** | Simplificação de processos fiscais e acesso a licitações |
| **Servidor** | Canal direto com a administração e acesso a holerite |
| **Produtor Rural** | Informações específicas da zona rural e defesa civil |
| **Prefeitura** | Redução de atendimentos presenciais, comunicação eficiente, transparência |

### 1.4 Inspiração de Mercado

O "Prefeitura de Brazópolis" se inspira na experiência de uso de aplicativos como:

- **Nubank** — simplicidade, cartões informativos, navegação intuitiva
- **iFood** — categorias visuais, busca por proximidade, notificações contextuais
- **Waze** — mapas inteligentes, informações em tempo real
- **Gov.br** — serviços públicos digitais, porém com UX muito mais moderna

A diferença é que este app **não é um portal institucional adaptado para celular**. É um **aplicativo pensado para o cidadão**, com linguagem simples, ações rápidas e visual premium.

---

## 2. Objetivos Estratégicos

### 2.1 Objetivos Primários

| # | Objetivo | Meta | Indicador |
|---|----------|------|-----------|
| O1 | Reduzir atendimentos presenciais | -40% no primeiro ano | Número de atendimentos/mês |
| O2 | Aumentar autosserviço digital | +60% de serviços feitos pelo app | Taxa de uso digital vs. presencial |
| O3 | Melhorar comunicação pública | 80% dos moradores recebendo notificações | Base de dispositivos com push ativo |
| O4 | Transparência em solicitações | 100% dos protocolos rastreáveis | Protocolos com acompanhamento |
| O5 | Engajamento recorrente | Média de 3 acessos/semana por usuário ativo | DAU/WAU/MAU |

### 2.2 Objetivos Secundários

| # | Objetivo | Descrição |
|---|----------|-----------|
| O6 | Fortalecer o turismo local | Roteiros interativos e informações geolocalizadas |
| O7 | Modernizar a imagem da gestão | App premium demonstra inovação pública |
| O8 | Base para SaaS municipal | Produto reutilizável para dezenas de prefeituras |
| O9 | Inclusão digital | Interface acessível para todas as idades |
| O10 | Dados para políticas públicas | Analytics anônimos sobre demandas e uso |

### 2.3 KPIs (Key Performance Indicators)

| KPI | Fórmula | Frequência |
|-----|---------|------------|
| Downloads totais | Soma acumulada | Mensal |
| Usuários ativos mensais (MAU) | Dispositivos únicos/mês | Mensal |
| Taxa de retenção D7/D30 | Retorno após 7/30 dias | Semanal |
| Protocolos abertos/mês | Contagem | Mensal |
| Tempo médio de resolução | Tempo entre abertura e conclusão | Mensal |
| Satisfação (NPS in-app) | Pesquisa anônima | Trimestral |
| Taxa de push opt-in | Dispositivos com push ativo | Mensal |
| Redução de atendimentos presenciais | Comparativo com período anterior | Trimestral |

---

## 3. Diagnóstico do Portal Atual

### 3.1 O que o portal faz bem

O portal da Prefeitura de Brazópolis oferece um conjunto completo de informações institucionais:

| Serviço | Status | Observação |
|---------|--------|------------|
| Notícias | ✅ Ativo | Atualizadas regularmente |
| Turismo | ✅ Ativo | Boa seção com pontos turísticos |
| Secretarias | ✅ Ativo | Páginas institucionais |
| IPTU | ✅ Ativo | Consulta e emissão de segunda via |
| Certidões | ✅ Ativo | Emissão online |
| Licitações | ✅ Ativo | Publicação de editais |
| Portal da Transparência | ✅ Ativo | Conforme a lei |
| Ouvidoria | ✅ Ativo | Formulário online |
| e-SIC | ✅ Ativo | Acesso à informação |
| Concursos | ✅ Ativo | Quando disponíveis |
| Informações institucionais | ✅ Ativo | Completas |
| Serviços online | ✅ Ativo | Diversos |

### 3.2 Limitações identificadas

| Problema | Impacto | Severidade |
|----------|---------|------------|
| **Acesso esporádico** | O cidadão só entra quando precisa de algo pontual (pagar IPTU, buscar telefone) | Alta |
| **Sem personalização** | Todos veem o mesmo conteúdo | Média |
| **Comunicação unidirecional** | Site publica, cidadão lê (se acessar) | Alta |
| **Mobile pouco otimizado** | Navegação complexa em telas pequenas | Alta |
| **Sem notificações** | Cidadão não sabe de prazos, campanhas, alertas | Crítica |
| **Ouvidoria burocrática** | Formulários longos sem uso de câmera/GPS | Média |
| **Sem acompanhamento** | Cidadão não sabe o que aconteceu com sua solicitação | Alta |
| **Sem interação proativa** | A prefeitura não consegue "ir até" o cidadão | Crítica |

### 3.3 Análise comparativa: Portal vs. App

| Aspecto | Portal Web | App "Prefeitura de Brazópolis" |
|---------|-----------|--------------------------|
| Acesso | Navegador, quando lembrar | Ícone no celular, sempre disponível |
| Comunicação | Passiva (site→cidadão) | Ativa (push notifications) |
| Personalização | Zero | Baseada em contexto local |
| Solicitações | Formulário genérico | Foto + GPS + categorias |
| Acompanhamento | Inexistente | Timeline em tempo real |
| Engajamento | Baixo (acesso pontual) | Alto (notificações, agenda, alertas) |
| Emergência | Nenhuma | Botão com discagem direta |
| Turismo | Páginas estáticas | Roteiros por proximidade com GPS |
| Pagamentos | Redirecionamento externo | PIX integrado no app |

---

## 4. Solução Proposta

### 4.1 Conceito

Um **superapp municipal anônimo**, inspirado em aplicativos de consumo (Nubank, iFood), organizado em torno das **necessidades reais** dos cidadãos — não da estrutura organizacional da prefeitura.

### 4.2 Três pilares

```
┌─────────────────────────────────────────────────────────────┐
│                  PREFEITURA NO BOLSO                        │
├────────────────┬───────────────────┬────────────────────────┤
│   📡 PROATIVO  │  🗺️ CONTEXTUAL   │  🔓 ABERTO            │
│                │                   │                        │
│ Notificações   │ GPS + Mapas       │ Sem login              │
│ Lembretes      │ Proximidade       │ Sem cadastro           │
│ Alertas        │ Informações locais│ Sem barreira           │
│ Agenda         │ Serviços próximos │ Acesso universal       │
└────────────────┴───────────────────┴────────────────────────┘
```

### 4.3 Identidade Visual (Paleta de Cores)

O app herda a identidade visual do site oficial da prefeitura:

| Token | Cor | Hex | Uso |
|-------|-----|-----|-----|
| Primary | 🔵 Azul Institucional | `#004A80` | Botões, headers, ícones principais |
| Primary Light | 🔵 Azul Claro | `#3185C2` | Hover, destaques secundários |
| Primary Dark | 🔵 Azul Escuro | `#003366` | Textos em destaque, backgrounds |
| Secondary | 🔴 Vermelho | `#dc004e` | Alertas, badges, emergência |
| WhatsApp | 🟢 Verde WhatsApp | `#25D366` | Botão "Falar com a Prefeitura" |
| Text Primary | ⚫ Cinza Escuro | `#3A3A3C` | Textos principais |
| Text Secondary | ⚪ Cinza | `#666666` | Textos secundários |
| Background | ⬜ Branco | `#ffffff` | Fundo geral |
| Tipografia | — | — | Roboto (família principal) |

### 4.4 Módulos do aplicativo

| Módulo | Ícone | Descrição |
|--------|-------|-----------|
| Home | 🏠 | Tela inicial universal com atalhos para todos os serviços |
| Notificações Push | 📢 | Campanhas, alertas, prazos, protocolos |
| Protocolos | 🚧 | Abrir e acompanhar solicitações com foto + GPS |
| Saúde | 🏥 | Campanhas, UBS, vacinação, horários |
| Educação | 🎓 | Calendário, merenda, transporte escolar |
| Turismo | 🗺️ | Pontos, roteiros, "Você está a X km" |
| IPTU e Pagamentos | 💰 | Consulta, segunda via, PIX |
| Eventos e Agenda | 🗓️ | Agenda da cidade com lembretes |
| Coleta de Lixo | 🚛 | Dias e horários por bairro |
| Emergência | 🚨 | Discagem rápida + localização |
| Concursos e Vagas | 📋 | Concursos, empregos, editais |
| Defesa Civil | ⛈️ | Alertas de chuva, áreas de risco |
| Chat | 💬 | Atendimento por árvore de decisão |
| Mapa Inteligente | 📍 | Camadas de serviços, rota, busca |
| Obras | 🏗️ | Acompanhamento de obras públicas com progresso |
| Ouvidoria | 📝 | Solicitação simplificada com foto e GPS |
| Certidões | 📄 | Emissão online sem login |
| Licitações | 📑 | Editais, pregões, resultados |
| Transparência | 🔍 | Portal da Transparência integrado |
| Favoritos | ⭐ | Atalhos personalizados localmente |
| Configurações | ⚙️ | Notificações, idioma, bairro |

### 4.5 Diferencial: WhatsApp da Prefeitura

Em vez de um chat proprietário, o app usa o **WhatsApp** como canal de comunicação direta. Ao clicar em "💬 Falar com a Prefeitura", o app abre uma conversa no WhatsApp com o número oficial.

```
┌──────────────────────────────────┐
│   💬 Falar com a Prefeitura      │
│                                  │
│   Abrir WhatsApp                 │
│   📱 (35) 3645-XXXX              │
│                                  │
│   Horário de atendimento:        │
│   Seg-Sex: 8h às 17h             │
└──────────────────────────────────┘
```

Vantagens:
- Canal que o cidadão **já conhece e usa diariamente**
- Sem necessidade de construir/manter chat proprietário
- A prefeitura pode usar **WhatsApp Business API** para automações futuras
- Histórico de conversa fica no WhatsApp do cidadão

### 4.6 Diferencial: Backend Já Existente

O projeto aproveita o **backend NestJS já desenvolvido** para o portal da prefeitura, que já possui módulos para:

| Módulo existente | Uso no app |
|-----------------|------------|
| `noticias` | Feed de notícias na Home |
| `concurso` | Lista de concursos |
| `cultura-turismo` | Pontos turísticos e roteiros |
| `educacao-documento` | Documentos e calendário escolar |
| `galeria` | Fotos de pontos turísticos e eventos |
| `licitacao` | Editais e licitações |
| `obra` | Acompanhamento de obras |
| `vacinacao` | Campanhas de vacinação |
| `secretarias` | Informações das secretarias |
| `indicador-saude` | Dados de saúde |
| `medicamento` | Lista de medicamentos |
| `carousel` | Banners e destaques |
| `contas-publicas` | Transparência |
| `assistencia-social` | Serviços sociais |
| `search` (MeiliSearch) | Busca inteligente no app |

Isso significa que **boa parte das APIs já existe**. O app Flutter consumirá essas mesmas APIs, e novos endpoints serão criados apenas para funcionalidades exclusivas do app (protocolos, notificações push, coleta de lixo, emergência).

### 4.7 Diferencial: Protocolos anônimos

Sem login, como acompanhar uma solicitação? Com um sistema de **código + chave**:

```
┌──────────────────────────────────────────┐
│   ✅ Solicitação enviada com sucesso!    │
│                                          │
│   Protocolo: #8342                       │
│   Chave de acesso: KX92M                │
│                                          │
│   📱 Salvar no celular                   │
│   🔔 Ativar notificações                │
│                                          │
│   Guarde estes dados para consultar      │
│   o andamento da sua solicitação.        │
└──────────────────────────────────────────┘
```

- O **código** identifica a solicitação
- A **chave** garante que só quem abriu pode acompanhar
- O **token do dispositivo** (Firebase Cloud Messaging) permite enviar push sobre mudanças de status
- Nenhum dado pessoal (CPF, nome, e-mail) é coletado

---

## 5. Públicos-Alvo

Embora não existam contas de usuário, o aplicativo atende cinco públicos distintos com necessidades diferentes.

### 5.1 Cidadão/Morador

| Atributo | Detalhe |
|----------|---------|
| **Quem é** | Residente da cidade, 18-70 anos, todas as classes sociais |
| **Dispositivo** | Smartphone Android (maioria) ou iPhone |
| **Frequência de uso** | 2-5x por semana (com notificações) |
| **Dores** | Esquece prazos de IPTU, não sabe quando a vacina está disponível, reclama de buracos e iluminação, quer saber da coleta |
| **Expectativas** | Receber lembretes, abrir protocolos rapidamente, ver agenda de saúde, acompanhar obras |
| **Módulos prioritários** | IPTU, Protocolos, Saúde, Coleta, Emergência, Eventos |

**Cenário típico:** João mora no bairro Centro. Abriu o app na segunda-feira e viu que a coleta reciclável é na terça. Na quarta, recebeu um push sobre a campanha de vacinação. Na sexta, fotografou um buraco na rua e abriu um protocolo. Três dias depois, recebeu push: "Equipe enviada".

### 5.2 Turista

| Atributo | Detalhe |
|----------|---------|
| **Quem é** | Visitante esporádico, 25-55 anos, busca lazer e cultura |
| **Dispositivo** | Smartphone com GPS ativo |
| **Frequência de uso** | Intenso durante a visita (5-15 acessos/dia) |
| **Dores** | Não conhece a cidade, não sabe o que fazer, informações espalhadas |
| **Expectativas** | Roteiros por proximidade, eventos, restaurantes, mapas offline |
| **Módulos prioritários** | Turismo, Mapa, Eventos, Emergência |

**Cenário típico:** Maria chegou a Brazópolis para o feriado. Instalou o app, escolheu "Turista". A Home mostra "Descubra Brazópolis" com pontos próximos. Ela clicou no Observatório, viu que está a 2 km, e ativou a rota no mapa.

### 5.3 Empresário/Prestador de Serviço

| Atributo | Detalhe |
|----------|---------|
| **Quem é** | Dono de comércio, indústria ou prestador de serviço local |
| **Dispositivo** | Smartphone e computador |
| **Frequência de uso** | 1-2x por semana para consultas e prazos |
| **Dores** | Emitir alvarás, pagar ISS, acompanhar licitações, obter certidões |
| **Expectativas** | Área com serviços empresariais, notificações de prazos fiscais, editais |
| **Módulos prioritários** | Licitações, Alvará, ISS, Certidões, IPTU |

**Cenário típico:** Carlos tem uma loja no centro. Recebeu notificação de nova licitação para fornecimento de materiais. Acessou o edital pelo app e baixou o PDF.

### 5.4 Servidor Público

| Atributo | Detalhe |
|----------|---------|
| **Quem é** | Funcionário efetivo ou comissionado da prefeitura |
| **Dispositivo** | Smartphone pessoal |
| **Frequência de uso** | 1-3x por semana |
| **Dores** | Acessar holerite, escalas, comunicados internos |
| **Expectativas** | Portal do servidor com acesso via matrícula (webview do sistema existente) |
| **Módulos prioritários** | Portal do Servidor, Comunicados, Holerite |

**Cenário típico:** Ana é professora municipal. No app, acessa o portal do servidor (via webview) para conferir o holerite. Também recebe avisos da secretaria de educação diretamente no push.

### 5.5 Produtor Rural

| Atributo | Detalhe |
|----------|---------|
| **Quem é** | Agricultor, pecuarista, morador da zona rural |
| **Dispositivo** | Smartphone com conexão intermitente |
| **Frequência de uso** | 1-2x por semana |
| **Dores** | Informações sobre patrolamento, coleta, apoio da defesa civil, feiras |
| **Expectativas** | Acesso a serviços rurais, alertas climáticos, modo offline |
| **Módulos prioritários** | Defesa Civil, Protocolos (patrolamento), Eventos (feiras), Coleta |

**Cenário típico:** José mora na zona rural. Recebeu alerta de chuva forte pelo app (push de defesa civil). Depois, abriu um protocolo solicitando patrolamento na estrada da sua fazenda, com foto e GPS.

---

## 6. Requisitos Funcionais

> **Convenção:** Cada requisito possui um ID único (RF-XXX), classificação de prioridade (Must/Should/Could/Won't — método MoSCoW), e módulo ao qual pertence.

### 6.1 Home Universal

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-001 | Na primeira abertura, exibir breve onboarding apresentando o app (3 telas) e depois a Home | Must |
| RF-002 | Saudação genérica baseada no horário (ex.: "Bom dia!") sem nome pessoal | Must |
| RF-003 | Seção de avisos importantes — até 3 cards destacados, vindos do painel administrativo (usa API de carousel existente) | Must |
| RF-004 | Widget de eventos do dia/semana com rolagem horizontal | Must |
| RF-005 | Grade de atalhos (3×3 ou 4×2) universal — mesma para todos os usuários, com os serviços mais usados | Must |
| RF-006 | Botão flutuante "🚨 Emergência" sempre visível na Home | Must |
| RF-007 | Bottom Navigation Bar fixa com 5 itens: Home, Mapa, Protocolos, WhatsApp, Menu | Must |
| RF-008 | Badge de notificações não lidas no ícone do sino | Should |
| RF-009 | Busca global usando MeiliSearch: o cidadão digita "IPTU" e encontra o módulo rapidamente | Should |
| RF-010 | Cards animados com informações contextuais (ex.: "IPTU vence em 5 dias") | Could |

### 6.2 Notificações e Alertas

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-011 | Solicitar permissão para notificações push na primeira abertura (com explicação clara do benefício) | Must |
| RF-012 | Inscrição automática em tópicos gerais: "municipio", "defesa_civil", "saude", "educacao" | Must |
| RF-013 | Opção de inscrição em tópicos por bairro (escolhidos na configuração) | Must |
| RF-014 | Para protocolos: ao abrir solicitação, o app oferece "Ativar notificações deste protocolo". O servidor associa o token FCM ao código do protocolo | Must |
| RF-015 | Central de notificações com histórico (armazenado localmente + últimas do servidor) | Must |
| RF-016 | Agrupamento de notificações por categoria (Saúde, IPTU, Protocolos, Eventos) | Should |
| RF-017 | Notificação silenciosa para atualizações de baixa prioridade | Should |
| RF-018 | Deep link: ao clicar na notificação, abrir a tela correspondente (ex.: protocolo, evento) | Must |
| RF-019 | Segmentação de push: enviar apenas para dispositivos inscritos no tópico relevante | Must |
| RF-020 | Rate limiting: máximo de 3 notificações/dia por categoria para evitar spam | Should |

### 6.3 Protocolos e Ouvidoria (Anônimos)

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-021 | Qualquer pessoa pode abrir solicitação sem se identificar | Must |
| RF-022 | Categorias de protocolo: Buraco, Poste apagado, Mato alto, Dengue (foco), Lixo irregular, Animal abandonado, Iluminação, Esgoto, Calçada danificada, Poda de árvore, Trânsito, Outros | Must |
| RF-023 | Campo obrigatório: foto (câmera ou galeria) | Must |
| RF-024 | Captura automática de localização GPS (com permissão) | Must |
| RF-025 | Campo opcional: descrição textual (máx. 500 caracteres) | Must |
| RF-026 | Após envio, exibir: número do protocolo + chave alfanumérica (5 caracteres) | Must |
| RF-027 | Opção "Salvar no celular": armazenar o par (número, chave) no armazenamento local | Must |
| RF-028 | Opção "Ativar notificações deste protocolo": associa token FCM ao protocolo | Must |
| RF-029 | Tela "Meus Protocolos" (local): lista de protocolos salvos no dispositivo com status | Must |
| RF-030 | Consulta manual: informar número + chave para verificar status sem ter salvo | Must |
| RF-031 | Timeline visual do protocolo: Recebido → Em análise → Equipe enviada → Concluído | Must |
| RF-032 | Notificação automática a cada mudança de status | Must |
| RF-033 | Exibição de foto de resolução (quando a equipe enviar foto do reparo) | Should |
| RF-034 | Ouvidoria simplificada: mesmo fluxo dos protocolos, com categorias específicas (elogio, reclamação, sugestão, denúncia) e opção de anonimato | Must |
| RF-035 | Protocolo pode receber mensagens do servidor (ex.: "Precisamos de mais detalhes") | Should |
| RF-036 | Opção de avaliar o atendimento ao final (1-5 estrelas, anônimo) | Could |

### 6.4 Módulo de Saúde

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-037 | Dashboard de saúde com cards: Campanhas Ativas, UBS, Vacinação, Telefones | Must |
| RF-038 | Lista de campanhas de vacinação ativas com datas, locais e público-alvo | Must |
| RF-039 | Lista de UBS com endereço, telefone, horário de funcionamento | Must |
| RF-040 | Botão "Ver no mapa" para cada UBS | Must |
| RF-041 | Botão de discagem direta para cada UBS | Must |
| RF-042 | Registro local de vacinas: usuário pode anotar manualmente vacinas tomadas (dados ficam apenas no celular) | Could |
| RF-043 | Notificação push quando nova campanha de vacinação iniciar | Must |
| RF-044 | Informação de plantão: qual UBS está aberta agora | Should |
| RF-045 | Fila de consultas (posição, se integração com sistema da saúde existir) | Could |

### 6.5 Módulo de Educação

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-046 | Calendário escolar oficial (estático ou carregado da API) | Must |
| RF-047 | Cardápio da merenda escolar por escola ou região | Should |
| RF-048 | Rotas de transporte escolar com mapa | Should |
| RF-049 | Comunicados da Secretaria de Educação | Must |
| RF-050 | Notificação push de férias, dias letivos, matrículas | Must |
| RF-051 | Lista de escolas municipais com endereço e telefone | Must |
| RF-052 | Botão "Ver no mapa" para cada escola | Must |

### 6.6 Módulo de Turismo

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-053 | Lista de pontos turísticos com descrição, fotos, horários e endereço | Must |
| RF-054 | "Você está a X km de [ponto turístico]" (cálculo GPS) | Must |
| RF-055 | Roteiros sugeridos (ex.: "Rota das Cachoeiras", "Centro Histórico") | Should |
| RF-056 | Botão "Ir agora" abre rota no mapa integrado ou Google Maps/Waze | Must |
| RF-057 | Eventos e festas tradicionais vinculados ao calendário | Must |
| RF-058 | Guia de restaurantes e hotéis (dados abertos ou cadastrados pela prefeitura) | Should |
| RF-059 | Galeria de fotos de cada ponto turístico | Should |
| RF-060 | Compartilhamento de ponto turístico via redes sociais/WhatsApp | Should |
| RF-061 | Modo offline: dados de turismo cacheados para uso sem internet | Could |

### 6.7 IPTU e Pagamentos

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-062 | Consulta de IPTU por inscrição imobiliária (sem login) | Must |
| RF-063 | Leitura de código de barras do carnê para buscar automaticamente | Should |
| RF-064 | Exibição de parcelas: pagas, em aberto, vencidas | Must |
| RF-065 | Emissão de segunda via (boleto em PDF ou código de barras) | Must |
| RF-066 | Geração de PIX copia-e-cola para pagamento | Must |
| RF-067 | Opção "Salvar esta inscrição" como favorito local | Must |
| RF-068 | Lembrete local de vencimento (alarme do celular, configurável) | Should |
| RF-069 | Histórico de consultas (armazenado localmente) | Should |
| RF-070 | Outros tributos: ISS, alvará, taxas (quando disponíveis via API) | Should |
| RF-071 | QR Code para pagamento de taxas diversas | Could |

### 6.8 Eventos e Agenda da Cidade

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-072 | Agenda unificada da cidade (oficial + comunitária) | Must |
| RF-073 | Filtro por categoria: cultura, esporte, saúde, educação, religioso, feiras | Must |
| RF-074 | Detalhes do evento: data, horário, local, descrição, mapa | Must |
| RF-075 | Botão "Lembrar-me" — cria alarme local no dispositivo | Must |
| RF-076 | Botão "Compartilhar" via WhatsApp/redes sociais | Should |
| RF-077 | Indicação "Começa em X dias" ou "Acontecendo agora" | Should |
| RF-078 | Notificação push para eventos marcados como destaque | Must |

### 6.9 Coleta de Lixo

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-079 | Informar bairro ou CEP e receber dias/horários de coleta | Must |
| RF-080 | Tipos de coleta: comum, reciclável, volumosos, lixo eletrônico | Must |
| RF-081 | Opção "Lembrar-me na véspera" (lembrete local) | Should |
| RF-082 | Pontos de entrega voluntária (PEVs) no mapa | Should |
| RF-083 | Dicas de reciclagem por categoria de material | Could |

### 6.10 Emergência

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-084 | Botão de emergência com destaque visual máximo (vermelho, grande) | Must |
| RF-085 | Lista de contatos de emergência: Polícia (190), SAMU (192), Bombeiros (193), Defesa Civil (199) | Must |
| RF-086 | Discagem direta com um toque | Must |
| RF-087 | Botão "Enviar minha localização" (compartilha GPS via SMS ou link) | Should |
| RF-088 | Números locais adicionais: hospital, farmácia de plantão, pronto-socorro | Should |

### 6.11 Concursos e Vagas

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-089 | Lista de concursos públicos abertos com detalhes | Must |
| RF-090 | Link externo para inscrição e download do edital | Must |
| RF-091 | Vagas de emprego (SINE, parcerias, mural de vagas da prefeitura) | Should |
| RF-092 | Notificação push ao publicar novo concurso | Must |
| RF-093 | Filtro por área de atuação | Should |

### 6.12 Serviços para Empresas (sem login)

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-094 | Consulta de alvará de funcionamento por CNPJ (via API pública) | Should |
| RF-095 | Emissão de certidão negativa de débitos por CNPJ | Should |
| RF-096 | Consulta e geração de ISS por CNPJ | Should |
| RF-097 | Lista de licitações abertas com link para edital | Must |
| RF-098 | Notificação de novas licitações (tópico "empresas") | Must |
| RF-099 | Notificações gerais sobre prazos fiscais | Should |

### 6.13 Serviços para Servidores Públicos (sem login no app)

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-100 | Acesso ao portal do servidor via WebView (sistema externo com matrícula + senha própria) | Must |
| RF-101 | Comunicados internos da administração (via push, tópico "servidores") | Should |
| RF-102 | Link direto para holerite, escalas, RH | Must |

### 6.14 Defesa Civil

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-103 | Alertas de tempo severo (chuva forte, ventania, granizo) — push obrigatório | Must |
| RF-104 | Mapa de áreas de risco e abrigos | Must |
| RF-105 | Botão "Estou em segurança" (feedback anônimo opcional) | Could |
| RF-106 | Histórico de alertas | Should |
| RF-107 | Instruções de segurança por tipo de emergência (enchente, deslizamento) | Should |

### 6.15 WhatsApp da Prefeitura

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-108 | Botão "Falar com a Prefeitura" abre conversa no WhatsApp (usando URL `wa.me/{numero}`) | Must |
| RF-109 | Mensagem pré-formatada ao abrir WhatsApp (ex.: "Olá! Preciso de ajuda com...") | Should |
| RF-110 | Lista de setores com números WhatsApp separados (Saúde, Obras, Educação, IPTU) — se disponíveis | Should |
| RF-111 | Horário de atendimento visível antes de abrir o WhatsApp | Must |
| RF-112 | Botão de WhatsApp também acessível via Bottom Navigation Bar | Must |
| RF-113 | Integração futura com WhatsApp Business API para chatbot automatizado | Could |

### 6.16 Mapa Inteligente

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-114 | Mapa base com Google Maps ou OpenStreetMap | Must |
| RF-115 | Camadas ativáveis: Saúde (UBS), Educação (escolas), Turismo, Coleta, Obras, Repartições | Must |
| RF-116 | Busca por endereço | Must |
| RF-117 | Traçar rota até um ponto selecionado | Must |
| RF-118 | Exibição de obras em andamento com progresso (barra %) | Should |
| RF-119 | Cluster de pontos quando muitos marcadores próximos | Should |

### 6.17 Acompanhamento de Obras

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-120 | Lista de obras públicas em andamento | Must |
| RF-121 | Detalhes: nome, local, tipo (pavimentação, drenagem, construção), responsável | Must |
| RF-122 | Barra de progresso visual (%) | Must |
| RF-123 | Localização no mapa | Must |
| RF-124 | Fotos de atualização periódica | Should |
| RF-125 | Notificação quando obra perto do cidadão é atualizada (baseada em bairro) | Could |

### 6.18 Customização Local (Favoritos)

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-126 | Grade de atalhos na Home editável pelo usuário (arrastar, adicionar, remover) | Should |
| RF-127 | Preferências de notificação por tópicos (ativar/desativar por categoria) | Must |
| RF-128 | Seleção de bairro para notificações localizadas | Must |
| RF-129 | Tela de configurações: limpar dados locais, sobre o app, política de privacidade, termos de uso | Must |
| RF-130 | Idioma: português (padrão), inglês, espanhol | Could |

### 6.19 Certidões

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-132 | Emissão de certidões por tipo: negativa de débitos, uso e ocupação do solo, valor venal | Must |
| RF-133 | Consulta por inscrição imobiliária ou CNPJ (sem login) | Must |
| RF-134 | Download do PDF da certidão | Must |
| RF-135 | Verificação de autenticidade por código | Should |

### 6.20 Portal da Transparência e Licitações

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-136 | Link direto para o Portal da Transparência (WebView) | Must |
| RF-137 | Lista de licitações com filtro por status (aberta, encerrada, em andamento) | Must |
| RF-138 | Download de editais em PDF | Must |
| RF-139 | Notificação push de novas licitações publicadas | Must |

### 6.21 Pagamentos (PIX integrado)

| ID | Requisito | Prioridade |
|----|-----------|------------|
| RF-140 | Geração de código PIX copia-e-cola para IPTU | Must |
| RF-141 | Geração de código PIX para ISS, alvará, taxas | Should |
| RF-142 | Botão "Copiar código PIX" | Must |
| RF-143 | QR Code do PIX para leitura por outro app bancário | Must |
| RF-144 | Comprovante de geração (não de pagamento — este é externo) | Should |

---

## 7. Requisitos Não-Funcionais

### 7.1 Desempenho

| ID | Requisito | Meta |
|----|-----------|------|
| RNF-01 | Tempo de carregamento da Home | < 2s em 4G |
| RNF-02 | Tempo de resposta das APIs | < 500ms (P95) |
| RNF-03 | Tempo de abertura do mapa | < 3s |
| RNF-04 | Tamanho do APK/IPA | < 30MB |
| RNF-05 | Consumo de bateria | Insignificante em background |

### 7.2 Disponibilidade e Confiabilidade

| ID | Requisito | Meta |
|----|-----------|------|
| RNF-06 | Disponibilidade do backend | 99.5% (exceto manutenções programadas) |
| RNF-07 | Recuperação de falhas | < 30 minutos (RTO) |
| RNF-08 | Backup de dados | Diário, retenção de 30 dias |
| RNF-09 | Graceful degradation | App funciona parcialmente offline |

### 7.3 Escalabilidade

| ID | Requisito | Meta |
|----|-----------|------|
| RNF-10 | Usuários simultâneos por município | Até 5.000 |
| RNF-11 | Suporte a múltiplos municípios (SaaS) | Até 200 |
| RNF-12 | Auto-scaling do backend | Horizontal, baseado em CPU/memória |
| RNF-13 | CDN para assets estáticos | Sim, CloudFront ou equivalente |

### 7.4 Segurança

| ID | Requisito | Meta |
|----|-----------|------|
| RNF-14 | Criptografia em trânsito | TLS 1.3 |
| RNF-15 | Criptografia em repouso | AES-256 para dados sensíveis |
| RNF-16 | Rate limiting na API | Sim, por IP e por endpoint |
| RNF-17 | Proteção contra injeção (SQL, XSS, CSRF) | Validação em todas as camadas |
| RNF-18 | Logs de auditoria | Ações administrativas e críticas |
| RNF-19 | Pentest periódico | Anual |

### 7.5 Compatibilidade

| ID | Requisito | Meta |
|----|-----------|------|
| RNF-20 | Android | 8.0+ (API 26+) |
| RNF-21 | iOS | 14.0+ |
| RNF-22 | Tamanhos de tela | 4.7" a 6.7" (responsivo) |
| RNF-23 | Orientação | Portrait (principal), landscape para mapa |

### 7.6 Acessibilidade

| ID | Requisito | Meta |
|----|-----------|------|
| RNF-24 | Leitores de tela | Compatível com TalkBack e VoiceOver |
| RNF-25 | Contraste mínimo | WCAG AA (4.5:1) |
| RNF-26 | Tamanho mínimo de toque | 48x48 dp |
| RNF-27 | Fonte ajustável | Respeitar configuração do sistema |

### 7.7 Offline e Cache

| ID | Requisito | Meta |
|----|-----------|------|
| RNF-28 | Modo offline | Dados essenciais cacheados localmente |
| RNF-29 | Cache de conteúdo estático | 24h (turismo, saúde, educação) |
| RNF-30 | Sincronização | Automática ao reconectar |
| RNF-31 | Indicador de modo offline | Banner visível informando ausência de conexão |

### 7.8 Internacionalização

| ID | Requisito | Meta |
|----|-----------|------|
| RNF-32 | Idioma padrão | Português (pt-BR) |
| RNF-33 | Idiomas adicionais | Inglês e Espanhol (para turistas) |
| RNF-34 | Formato de datas e números | Locale-aware |

---

## 8. Jornadas do Usuário

### 8.1 Jornada: Morador abre protocolo de buraco

```
┌──────────────────────────────────────────────────────────────────┐
│                    JORNADA: PROTOCOLO DE BURACO                  │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. Abre o app                                                   │
│     └── Home exibe "Bom dia!" e atalhos                         │
│                                                                  │
│  2. Toca em "🚧 Solicitações"                                   │
│     └── Tela de categorias aparece                               │
│                                                                  │
│  3. Seleciona "Buraco"                                           │
│     └── Câmera abre automaticamente                              │
│                                                                  │
│  4. Tira foto do buraco                                          │
│     └── GPS captura localização                                  │
│                                                                  │
│  5. (Opcional) Adiciona descrição                                │
│     └── "Buraco grande na esquina da Rua das Flores"            │
│                                                                  │
│  6. Toca "Enviar"                                                │
│     └── Tela de confirmação:                                     │
│         Protocolo #5730 | Chave: FT42B                          │
│         [📱 Salvar] [🔔 Notificações]                           │
│                                                                  │
│  7. Ativa notificações                                           │
│     └── Token do dispositivo vinculado ao protocolo             │
│                                                                  │
│  8. 3 dias depois                                                │
│     └── Push: "Protocolo #5730: Equipe enviada 🔧"             │
│                                                                  │
│  9. 5 dias depois                                                │
│     └── Push: "Protocolo #5730: Concluído ✅"                   │
│     └── Foto do reparo disponível no app                        │
│                                                                  │
│ 10. (Opcional) Avalia: ⭐⭐⭐⭐⭐                               │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

### 8.2 Jornada: Turista explora a cidade

```
┌──────────────────────────────────────────────────────────────────┐
│                    JORNADA: TURISTA EXPLORA                      │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. Instala o app na Play Store                                  │
│     └── Splash Screen + Onboarding (3 telas)                    │
│                                                                  │
│  2. Seleciona perfil "🧳 Turista"                               │
│     └── Salvo localmente                                        │
│                                                                  │
│  3. Home mostra "Descubra Brazópolis"                            │
│     └── Cards: "Pontos próximos", "Eventos", "Onde comer"      │
│                                                                  │
│  4. Toca "Pontos próximos"                                       │
│     └── Lista ordenada por distância                            │
│     └── "Observatório — 2.3 km"                                 │
│                                                                  │
│  5. Toca no Observatório                                         │
│     └── Galeria de fotos, descrição, horários                   │
│     └── Botão "Ir agora" abre rota no mapa                     │
│                                                                  │
│  6. Visita o local                                               │
│     └── Compartilha no WhatsApp                                 │
│                                                                  │
│  7. Busca restaurantes para almoçar                              │
│     └── Lista próxima com avaliações                            │
│                                                                  │
│  8. Verifica eventos da noite                                    │
│     └── "Festa Junina no Largo — 19h"                           │
│     └── [Lembrar-me]                                            │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

### 8.3 Jornada: Pagamento de IPTU sem login

```
┌──────────────────────────────────────────────────────────────────┐
│                    JORNADA: PAGAMENTO IPTU                       │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. Na Home, toca "💰 IPTU"                                     │
│                                                                  │
│  2. Digita inscrição imobiliária                                 │
│     └── OU escaneia código de barras do carnê                   │
│                                                                  │
│  3. Visualiza débitos                                            │
│     └── Parcela 3/10 — R$ 142,50 — Vence 15/07                │
│     └── Parcela 4/10 — R$ 142,50 — Vence 15/08                │
│                                                                  │
│  4. Seleciona parcela 3                                          │
│     └── [Gerar Boleto] [PIX]                                    │
│                                                                  │
│  5. Toca "PIX"                                                   │
│     └── QR Code na tela + código copia-e-cola                   │
│     └── Botão "Copiar código"                                   │
│                                                                  │
│  6. Abre app bancário, paga                                      │
│                                                                  │
│  7. (Opcional) Salva inscrição como favorito                     │
│     └── Próxima vez: acesso direto sem digitar                  │
│                                                                  │
│  8. Configura lembrete: "Avisar 5 dias antes do vencimento"     │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

### 8.4 Jornada: Empresário acompanha licitação

```
┌──────────────────────────────────────────────────────────────────┐
│                    JORNADA: LICITAÇÃO                            │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. Escolheu perfil "🏢 Empresário"                             │
│     └── Home mostra: Licitações, Alvará, ISS, Certidões        │
│                                                                  │
│  2. Recebe push: "Nova licitação publicada: Materiais de..."    │
│                                                                  │
│  3. Abre a notificação                                           │
│     └── Detalhes: Pregão Eletrônico 023/2026                   │
│     └── Objeto, valor estimado, prazo                           │
│                                                                  │
│  4. Baixa edital em PDF                                          │
│                                                                  │
│  5. Salva licitação nos favoritos locais                        │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

### 8.5 Jornada: Alerta de Defesa Civil

```
┌──────────────────────────────────────────────────────────────────┐
│                    JORNADA: ALERTA DE CHUVA                     │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. Push urgente (mesmo com celular silencioso):                 │
│     "⛈️ ALERTA: Chuva forte prevista para as próximas 2h"      │
│                                                                  │
│  2. Ao abrir, tela de Defesa Civil mostra:                      │
│     └── Nível do alerta: ALTO                                  │
│     └── Áreas de risco no mapa                                  │
│     └── Abrigos abertos (com endereço e rota)                   │
│     └── Instruções de segurança                                 │
│                                                                  │
│  3. Botão "📍 Estou em segurança"                               │
│     └── Feedback anônimo para a defesa civil                    │
│                                                                  │
│  4. Botão "🚨 Emergência"                                       │
│     └── Discagem direta para Defesa Civil (199)                 │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## 9. Wireframes Descritivos

> Os mockups de alta fidelidade estão no **Volume 2 – UX/UI**. Aqui apresentamos a estrutura das principais telas.

### 9.1 Splash Screen
- Fundo com gradiente (azul escuro → azul claro)
- Logotipo da prefeitura centralizado (animação de fade-in)
- Nome "Prefeitura de Brazópolis" abaixo, com animação de slide-up
- Indicador de carregamento sutil

### 9.2 Onboarding (3 telas com swipe)
- **Tela 1:** "Serviços na palma da mão" — Ilustração de smartphone com serviços
- **Tela 2:** "Receba alertas importantes" — Ilustração de notificações
- **Tela 3:** "Quem é você?" — Seletor de perfil com botões grandes

### 9.3 Home — Morador
```
┌─────────────────────────┐
│ ☀️ Bom dia!         🔔  │
├─────────────────────────┤
│ ┌─────────────────────┐ │
│ │ 📢 Vacinação amanhã │ │
│ └─────────────────────┘ │
│ ┌─────────────────────┐ │
│ │ 📢 IPTU vence em 5d │ │
│ └─────────────────────┘ │
├─────────────────────────┤
│ 🗓 Eventos de hoje      │
│ [Feira] [Campeonato]    │
├─────────────────────────┤
│ ┌───┐ ┌───┐ ┌───┐      │
│ │💰 │ │🏥 │ │🎓 │      │
│ │IPTU│ │Saú│ │Edu│      │
│ └───┘ └───┘ └───┘      │
│ ┌───┐ ┌───┐ ┌───┐      │
│ │🚌 │ │🚧 │ │🚛 │      │
│ │Tran│ │Sol│ │Col│      │
│ └───┘ └───┘ └───┘      │
│ ┌───┐ ┌───┐ ┌───┐      │
│ │🗓 │ │📋 │ │⚙️ │      │
│ │Eve│ │Cer│ │Con│      │
│ └───┘ └───┘ └───┘      │
├─────────────────────────┤
│ 🏠  📍  🚧  💬  ☰      │
│ Home Map Proto Chat Menu│
└─────────────────────────┘
    🔴 🚨 Emergência
```

### 9.4 Home — Turista
```
┌─────────────────────────┐
│ 🧳 Descubra Brazópolis  │
├─────────────────────────┤
│ 🔍 O que você procura?  │
├─────────────────────────┤
│ ┌─────────────────────┐ │
│ │ 🏔 Pontos Turísticos│ │
│ │    12 locais         │ │
│ └─────────────────────┘ │
│ ┌─────────────────────┐ │
│ │ 🎉 Eventos          │ │
│ │    3 esta semana     │ │
│ └─────────────────────┘ │
│ ┌─────────────────────┐ │
│ │ 🍽 Onde Comer        │ │
│ │    8 restaurantes    │ │
│ └─────────────────────┘ │
│ ┌─────────────────────┐ │
│ │ 🏨 Onde Ficar        │ │
│ │    5 opções          │ │
│ └─────────────────────┘ │
├─────────────────────────┤
│    [Mapa minimizado]    │
│ "Você está no Centro"   │
├─────────────────────────┤
│ 🏠  📍  🚧  💬  ☰      │
└─────────────────────────┘
```

### 9.5 Tela de Protocolo — Categorias
```
┌─────────────────────────┐
│ ← Abrir Solicitação     │
├─────────────────────────┤
│                          │
│ O que você quer reportar?│
│                          │
│ ┌─────────┐ ┌─────────┐ │
│ │ 🕳️      │ │ 💡      │ │
│ │ Buraco  │ │ Poste   │ │
│ └─────────┘ └─────────┘ │
│ ┌─────────┐ ┌─────────┐ │
│ │ 🌿      │ │ 🦟      │ │
│ │ Mato    │ │ Dengue  │ │
│ └─────────┘ └─────────┘ │
│ ┌─────────┐ ┌─────────┐ │
│ │ 🗑️      │ │ 🐕      │ │
│ │ Lixo    │ │ Animal  │ │
│ └─────────┘ └─────────┘ │
│ ┌─────────┐ ┌─────────┐ │
│ │ 🚰      │ │ 🚶      │ │
│ │ Esgoto  │ │ Calçada │ │
│ └─────────┘ └─────────┘ │
│ ┌─────────┐ ┌─────────┐ │
│ │ 🌳      │ │ ❓      │ │
│ │ Poda    │ │ Outros  │ │
│ └─────────┘ └─────────┘ │
│                          │
└─────────────────────────┘
```

### 9.6 Tela de Acompanhar Protocolo
```
┌──────────────────────────┐
│ ← Protocolo #5730       │
├──────────────────────────┤
│                           │
│  📷 [Foto do buraco]     │
│                           │
│  📍 Rua das Flores, 123  │
│  📝 "Buraco na esquina"  │
│                           │
│  ─────────────────────── │
│                           │
│  ● Recebido       10/06  │
│  │                        │
│  ● Em análise     12/06  │
│  │                        │
│  ● Equipe enviada 13/06  │
│  │                        │
│  ○ Concluído       ----  │
│                           │
│  ─────────────────────── │
│                           │
│  Status atual:            │
│  🔧 Equipe enviada       │
│                           │
│  [🔔 Notificações: ON]   │
│                           │
└──────────────────────────┘
```

### 9.7 Configurações
```
┌──────────────────────────┐
│ ← Configurações         │
├──────────────────────────┤
│                           │
│  👤 Perfil                │
│     Morador  [Alterar]    │
│                           │
│  📍 Meu Bairro            │
│     Centro  [Alterar]     │
│                           │
│  🔔 Notificações          │
│     ☑ Saúde               │
│     ☑ Educação            │
│     ☑ IPTU                │
│     ☑ Defesa Civil        │
│     ☐ Licitações          │
│     ☐ Concursos           │
│     ☑ Eventos             │
│     ☑ Protocolos          │
│                           │
│  🌐 Idioma                │
│     Português  [Alterar]  │
│                           │
│  ⭐ Favoritos             │
│     [Editar atalhos]      │
│                           │
│  🗑️ Limpar dados locais  │
│  📄 Política de privac.  │
│  📄 Termos de uso         │
│  ℹ️ Sobre o app            │
│     Versão 1.0.0          │
│                           │
└──────────────────────────┘
```

---

## 10. Matriz de Funcionalidades por Perfil

| Funcionalidade | Morador | Turista | Empresário | Servidor | Produtor Rural |
|---------------|---------|---------|------------|----------|---------------|
| IPTU | ⭐ Destaque | Oculto | Visível | Visível | Visível |
| Saúde | ⭐ Destaque | Visível | Oculto | Visível | ⭐ Destaque |
| Educação | ⭐ Destaque | Oculto | Oculto | Visível | Visível |
| Turismo | Visível | ⭐ Destaque | Oculto | Oculto | Oculto |
| Protocolos | ⭐ Destaque | Visível | Visível | Visível | ⭐ Destaque |
| Coleta de lixo | ⭐ Destaque | Oculto | Oculto | Visível | ⭐ Destaque |
| Obras | Visível | Oculto | Visível | Visível | Visível |
| Licitações | Oculto | Oculto | ⭐ Destaque | Visível | Oculto |
| ISS / Alvará | Oculto | Oculto | ⭐ Destaque | Oculto | Oculto |
| Portal do Servidor | Oculto | Oculto | Oculto | ⭐ Destaque | Oculto |
| Holerite | Oculto | Oculto | Oculto | ⭐ Destaque | Oculto |
| Concursos | Visível | Oculto | Oculto | Visível | Visível |
| Eventos | Visível | ⭐ Destaque | Oculto | Visível | Visível |
| Emergência | ⭐ Sempre | ⭐ Sempre | ⭐ Sempre | ⭐ Sempre | ⭐ Sempre |
| Defesa Civil | Visível | Visível | Visível | Visível | ⭐ Destaque |
| Mapa | Visível | ⭐ Destaque | Visível | Visível | Visível |
| Chat | Visível | Visível | Visível | Visível | Visível |
| Restaurantes | Oculto | ⭐ Destaque | Oculto | Oculto | Oculto |
| Hotéis | Oculto | ⭐ Destaque | Oculto | Oculto | Oculto |
| Certidões | Visível | Oculto | ⭐ Destaque | Visível | Visível |
| Patrolamento | Oculto | Oculto | Oculto | Oculto | ⭐ Destaque |

> **Legenda:** ⭐ Destaque = aparece na grade principal da Home. Visível = acessível pelo menu. Oculto = não aparece por padrão (mas pode ser adicionado via favoritos).

---

## 11. Considerações LGPD e Privacidade

### 11.1 Postura do aplicativo

Como o app **não coleta dados pessoais** (sem CPF, nome, e-mail, conta), o risco de privacidade é drasticamente reduzido em relação a apps com cadastro.

### 11.2 Dados tratados

| Dado | Tipo | Finalidade | Armazenamento | Consentimento |
|------|------|-----------|---------------|---------------|
| Token FCM | Pseudonimizado | Envio de notificações push | Servidor (sem vinculação a identidade) | Solicitado na primeira abertura |
| Localização GPS | Pessoal (momentâneo) | Abertura de protocolos | Enviado apenas no ato da solicitação | Solicitado ao abrir câmera |
| Foto | Pessoal (momentâneo) | Anexo ao protocolo | Servidor, vinculado ao protocolo | Consentimento implícito ao fotografar |
| Perfil escolhido | Preferência local | Personalização da Home | Apenas no dispositivo | Escolha voluntária |
| Favoritos | Preferência local | Atalhos na Home | Apenas no dispositivo | Ação do usuário |
| Inscrição IPTU salva | Dado tributário | Consulta rápida | Apenas no dispositivo | Ação do usuário |

### 11.3 Direitos do titular

| Direito LGPD | Como é atendido |
|-------------|-----------------|
| Acesso | O cidadão pode ver seus dados locais a qualquer momento |
| Eliminação | Botão "Limpar dados locais" nas configurações apaga tudo |
| Portabilidade | Não aplicável (não há conta) |
| Revogação do consentimento | Desativar notificações e localização nas configurações do celular |
| Oposição | Não há perfilamento ou decisão automatizada |

### 11.4 Medidas técnicas

- Política de privacidade acessível a qualquer momento no app
- Termos de uso claros na primeira abertura (sem obrigar aceite para usar)
- Dados de protocolo (foto, GPS) são retidos pelo período necessário para resolução + prazo legal
- Token FCM não é cruzado com nenhuma outra informação
- Relatório de Impacto à Proteção de Dados Pessoais (RIPD) recomendado para funcionalidades de geolocalização
- Encarregado de dados (DPO) da prefeitura indicado no app

---

## 12. Glossário

| Termo | Definição |
|-------|-----------|
| **App** | Aplicativo móvel para Android e iOS |
| **FCM** | Firebase Cloud Messaging — serviço de notificações push do Google |
| **GPS** | Global Positioning System — localização geográfica |
| **IPTU** | Imposto Predial e Territorial Urbano |
| **ISS** | Imposto Sobre Serviços |
| **LGPD** | Lei Geral de Proteção de Dados (Lei 13.709/2018) |
| **PIX** | Sistema de pagamento instantâneo do Banco Central do Brasil |
| **Protocolo** | Solicitação de serviço público registrada pelo cidadão |
| **Push** | Notificação enviada pelo servidor ao dispositivo móvel |
| **SaaS** | Software as a Service — modelo de distribuição por assinatura |
| **Token** | Identificador único do dispositivo para receber notificações |
| **UBS** | Unidade Básica de Saúde |
| **WebView** | Componente que exibe páginas web dentro do app |
| **Wireframe** | Esboço estrutural de uma tela, sem design visual |

---

## 13. Referências

| # | Referência |
|---|-----------|
| 1 | Portal da Prefeitura de Brazópolis — https://brazopolis.mg.gov.br |
| 2 | Lei Geral de Proteção de Dados — Lei 13.709/2018 |
| 3 | Marco Civil da Internet — Lei 12.965/2014 |
| 4 | WCAG 2.1 — Web Content Accessibility Guidelines |
| 5 | Material Design 3 — Google Design Guidelines |
| 6 | Human Interface Guidelines — Apple |
| 7 | Firebase Cloud Messaging — Documentação oficial |
| 8 | Flutter — Documentação oficial |
| 9 | NestJS — Documentação oficial |

---

> **Nota:** Este Volume 1 é a fundação conceitual do projeto. Ele garante alinhamento entre as partes interessadas antes de qualquer investimento em design ou código. Os volumes subsequentes detalham UX/UI (Vol. 2), Arquitetura (Vol. 3), Diagramas UML (Vol. 4), Backlog (Vol. 5), Guia do Desenvolvedor (Vol. 6), APIs (Vol. 7) e Documento Comercial (Vol. 8).
