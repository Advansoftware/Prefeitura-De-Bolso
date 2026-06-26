<![CDATA[# 🔌 Volume 5 — Especificação de APIs

## Projeto "Prefeitura no Bolso"

| Item | Detalhe |
|------|---------|
| **Base URL** | `https://api.brazopolis.mg.gov.br/v1` |
| **Formato** | JSON |
| **Autenticação** | Header `X-App-Key` (app móvel), JWT Bearer (admin) |
| **Rate Limiting** | 100 req/min por IP |

---

## Sumário

1. [APIs Existentes (consumir)](#1-apis-existentes-consumir)
2. [Novas APIs — Protocolos](#2-novas-apis--protocolos)
3. [Novas APIs — Notificações Push](#3-novas-apis--notificações-push)
4. [Novas APIs — Coleta de Lixo](#4-novas-apis--coleta-de-lixo)
5. [Novas APIs — Eventos](#5-novas-apis--eventos)
6. [Novas APIs — Emergência](#6-novas-apis--emergência)
7. [Novas APIs — IPTU (Wrapper)](#7-novas-apis--iptu-wrapper)
8. [Busca Global (MeiliSearch)](#8-busca-global-meilisearch)
9. [Códigos de Erro](#9-códigos-de-erro)
10. [Paginação](#10-paginação)

---

## 1. APIs Existentes (consumir)

Estas APIs **já existem** no backend e o app Flutter deve consumir diretamente:

| Módulo | Endpoint existente | Método | Uso no app |
|--------|-------------------|--------|-----------|
| Notícias | `GET /public/noticias` | GET | Feed da Home |
| Notícia detalhe | `GET /public/noticias/:slug` | GET | Tela de detalhe |
| Carousel | `GET /public/carousel` | GET | Hero da Home |
| Concursos | `GET /public/concurso` | GET | Lista de concursos |
| Cultura/Turismo | `GET /public/cultura-turismo` | GET | Pontos turísticos |
| Educação | `GET /public/educacao-documento` | GET | Documentos educação |
| Galeria | `GET /public/galeria` | GET | Fotos turismo/eventos |
| Licitações | `GET /public/licitacoes` | GET | Lista de editais |
| Obras | `GET /public/obra` | GET | Lista de obras |
| Vacinação | `GET /public/vacinacao` | GET | Campanhas ativas |
| Secretarias | `GET /public/secretarias` | GET | Informações das secretarias |
| Indicadores Saúde | `GET /public/indicador-saude` | GET | Dashboard saúde |
| Medicamentos | `GET /public/medicamento` | GET | Lista de medicamentos |
| Contas Públicas | `GET /public/contas-publicas` | GET | Transparência |
| Assistência Social | `GET /public/assistencia-social` | GET | Serviços sociais |
| Conselhos | `GET /public/conselhos` | GET | Conselhos municipais |
| LGPD | `GET /public/lgpd` | GET | Política de privacidade |
| Busca | `GET /search` | GET | Busca global |

> **Nota:** Consultar a documentação de cada módulo no backend para parâmetros exatos de query, paginação e filtros.

---

## 2. Novas APIs — Protocolos

### 2.1 Criar Protocolo

```
POST /public/protocolo
Content-Type: multipart/form-data
X-App-Key: {app_key}
```

**Body (multipart):**

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| `categoria` | string | ✅ | Ex: "buraco", "poste_apagado", "dengue" |
| `descricao` | string | ❌ | Descrição opcional do problema |
| `latitude` | number | ✅ | Latitude GPS |
| `longitude` | number | ✅ | Longitude GPS |
| `endereco` | string | ✅ | Endereço (geocoding reverso) |
| `foto` | file | ✅ | Imagem JPEG/PNG (max 5MB) |
| `fcmToken` | string | ❌ | Token FCM para receber updates |

**Response 201:**

```json
{
  "codigo": "5730",
  "chave": "FT42B",
  "status": "recebido",
  "createdAt": "2026-06-26T14:30:00Z",
  "mensagem": "Protocolo criado com sucesso!"
}
```

**Response 400:**

```json
{
  "statusCode": 400,
  "message": ["foto deve ser uma imagem válida (JPEG, PNG)"],
  "error": "Bad Request"
}
```

**Response 429:**

```json
{
  "statusCode": 429,
  "message": "Limite de 10 protocolos/hora atingido",
  "error": "Too Many Requests"
}
```

### 2.2 Consultar Protocolo por Código

```
GET /public/protocolo/:codigo?chave={chave}
X-App-Key: {app_key}
```

**Response 200:**

```json
{
  "codigo": "5730",
  "categoria": "buraco",
  "descricao": "Buraco na via dificulta o tráfego",
  "endereco": "Rua das Flores, 123 - Centro",
  "latitude": -22.4739,
  "longitude": -45.6083,
  "fotoUrl": "https://minio.brazopolis.mg.gov.br/protocolos/5730-foto.jpg",
  "status": "equipe_enviada",
  "createdAt": "2026-06-10T08:00:00Z",
  "updatedAt": "2026-06-13T10:30:00Z",
  "timeline": [
    {
      "status": "recebido",
      "data": "2026-06-10T08:00:00Z",
      "observacao": null
    },
    {
      "status": "em_analise",
      "data": "2026-06-12T09:15:00Z",
      "observacao": "Encaminhado à Secretaria de Obras"
    },
    {
      "status": "equipe_enviada",
      "data": "2026-06-13T10:30:00Z",
      "observacao": "Equipe 3 enviada ao local"
    }
  ]
}
```

**Response 404:**

```json
{
  "statusCode": 404,
  "message": "Protocolo não encontrado ou chave inválida",
  "error": "Not Found"
}
```

### 2.3 Listar Categorias de Protocolo

```
GET /public/protocolo/categorias
X-App-Key: {app_key}
```

**Response 200:**

```json
[
  { "id": "buraco", "nome": "Buraco", "icone": "pothole" },
  { "id": "poste_apagado", "nome": "Poste apagado", "icone": "streetlight" },
  { "id": "mato_alto", "nome": "Mato alto", "icone": "grass" },
  { "id": "dengue", "nome": "Dengue", "icone": "mosquito" },
  { "id": "lixo_irregular", "nome": "Lixo irregular", "icone": "trash" },
  { "id": "animal_abandonado", "nome": "Animal abandonado", "icone": "pet" },
  { "id": "esgoto", "nome": "Esgoto", "icone": "water" },
  { "id": "calcada", "nome": "Calçada danificada", "icone": "sidewalk" },
  { "id": "poda", "nome": "Poda de árvore", "icone": "tree" },
  { "id": "outros", "nome": "Outros", "icone": "question" }
]
```

---

## 3. Novas APIs — Notificações Push

### 3.1 Registrar Dispositivo

```
POST /public/push/register
Content-Type: application/json
X-App-Key: {app_key}
```

**Body:**

```json
{
  "fcmToken": "fK3jX...(token FCM)",
  "topicos": ["municipio", "saude", "educacao", "defesa_civil"],
  "bairro": "centro",
  "plataforma": "android"
}
```

**Response 200:**

```json
{
  "mensagem": "Dispositivo registrado com sucesso",
  "topicos": ["municipio", "saude", "educacao", "defesa_civil"]
}
```

### 3.2 Atualizar Tópicos

```
PATCH /public/push/topicos
Content-Type: application/json
X-App-Key: {app_key}
```

**Body:**

```json
{
  "fcmToken": "fK3jX...",
  "topicos": ["municipio", "saude", "defesa_civil"],
  "bairro": "bairro_alto"
}
```

**Response 200:**

```json
{
  "mensagem": "Preferências atualizadas",
  "topicos": ["municipio", "saude", "defesa_civil"]
}
```

### 3.3 Enviar Notificação (Admin)

```
POST /admin/push/send
Authorization: Bearer {jwt_token}
Content-Type: application/json
```

**Body:**

```json
{
  "titulo": "Vacinação contra gripe começa amanhã",
  "corpo": "UBS Centro e UBS Bairro Alto das 8h às 16h. Traga sua carteira de vacinação.",
  "topico": "saude",
  "deepLink": "/saude/vacinacao",
  "imagemUrl": "https://minio.../vacina.jpg"
}
```

---

## 4. Novas APIs — Coleta de Lixo

### 4.1 Consultar Horários por Bairro

```
GET /public/coleta-lixo/:bairro
X-App-Key: {app_key}
```

**Response 200:**

```json
{
  "bairro": "Centro",
  "horarios": [
    {
      "tipoColeta": "comum",
      "diasSemana": ["terça", "quinta", "sábado"],
      "horario": "7h às 12h"
    },
    {
      "tipoColeta": "reciclavel",
      "diasSemana": ["quarta"],
      "horario": "8h às 14h"
    },
    {
      "tipoColeta": "volumosos",
      "diasSemana": ["sábado"],
      "horario": "Primeiro sábado do mês",
      "observacao": "Agendar pelo WhatsApp"
    }
  ],
  "pontosEntrega": [
    {
      "nome": "Ecoponto Centro",
      "endereco": "Rua da Matriz, 100",
      "latitude": -22.4740,
      "longitude": -45.6085
    }
  ]
}
```

### 4.2 Listar Bairros

```
GET /public/coleta-lixo/bairros
X-App-Key: {app_key}
```

**Response 200:**

```json
["Centro", "Bairro Alto", "Jardim", "Vila Nova", "São Sebastião"]
```

---

## 5. Novas APIs — Eventos

### 5.1 Listar Eventos

```
GET /public/evento?page=1&limit=10&categoria=cultura&dataInicio=2026-06-26
X-App-Key: {app_key}
```

**Response 200:**

```json
{
  "data": [
    {
      "id": 1,
      "titulo": "Feira Municipal",
      "descricao": "Feira de produtores locais com artesanato e gastronomia",
      "categoria": "cultura",
      "dataInicio": "2026-06-26T08:00:00Z",
      "dataFim": "2026-06-26T14:00:00Z",
      "local": "Praça Central",
      "latitude": -22.4735,
      "longitude": -45.6080,
      "imagemUrl": "https://minio.../feira.jpg",
      "destaque": true
    }
  ],
  "meta": {
    "total": 15,
    "page": 1,
    "limit": 10,
    "totalPages": 2
  }
}
```

### 5.2 Eventos em Destaque (Home)

```
GET /public/evento/destaque
X-App-Key: {app_key}
```

**Response 200:** Array dos 5 próximos eventos em destaque.

---

## 6. Novas APIs — Emergência

### 6.1 Telefones Úteis

```
GET /public/emergencia/telefones
X-App-Key: {app_key}
```

**Response 200:**

```json
[
  { "nome": "Polícia Militar", "telefone": "190", "categoria": "policia", "icone": "shield" },
  { "nome": "SAMU", "telefone": "192", "categoria": "saude", "icone": "ambulance" },
  { "nome": "Bombeiros", "telefone": "193", "categoria": "bombeiros", "icone": "fire" },
  { "nome": "Defesa Civil", "telefone": "199", "categoria": "defesa_civil", "icone": "alert" },
  { "nome": "Prefeitura", "telefone": "(35) 3645-1234", "categoria": "prefeitura", "icone": "building" },
  { "nome": "UBS Centro", "telefone": "(35) 3645-5678", "categoria": "saude", "icone": "hospital" }
]
```

### 6.2 WhatsApp da Prefeitura

```
GET /public/emergencia/whatsapp
X-App-Key: {app_key}
```

**Response 200:**

```json
{
  "numeroGeral": "5535364512340",
  "horario": "Seg-Sex: 8h às 17h",
  "setores": [
    { "nome": "Saúde", "numero": "5535364511110", "horario": "Seg-Sex: 7h às 17h" },
    { "nome": "Obras", "numero": "5535364522220", "horario": "Seg-Sex: 8h às 17h" },
    { "nome": "Educação", "numero": "5535364533330", "horario": "Seg-Sex: 8h às 16h" },
    { "nome": "IPTU", "numero": "5535364544440", "horario": "Seg-Sex: 8h às 17h" }
  ],
  "mensagemPadrao": "Olá! Estou entrando em contato pelo app Prefeitura no Bolso."
}
```

---

## 7. Novas APIs — IPTU (Wrapper)

### 7.1 Consultar Débitos

```
GET /public/iptu/:inscricao
X-App-Key: {app_key}
```

**Response 200:**

```json
{
  "inscricao": "01.02.003.004",
  "endereco": "Rua das Flores, 123 - Centro",
  "contribuinte": "NOME PARCIAL***",
  "parcelas": [
    { "numero": 1, "valor": 142.50, "vencimento": "2026-03-15", "status": "pago" },
    { "numero": 2, "valor": 142.50, "vencimento": "2026-05-15", "status": "pago" },
    { "numero": 3, "valor": 142.50, "vencimento": "2026-07-15", "status": "pendente" },
    { "numero": 4, "valor": 142.50, "vencimento": "2026-09-15", "status": "pendente" }
  ],
  "valorTotal": 570.00,
  "valorPago": 285.00,
  "valorPendente": 285.00
}
```

### 7.2 Gerar Boleto

```
GET /public/iptu/:inscricao/boleto/:parcela
X-App-Key: {app_key}
Accept: application/pdf
```

**Response 200:** PDF do boleto bancário.

### 7.3 Gerar PIX

```
GET /public/iptu/:inscricao/pix/:parcela
X-App-Key: {app_key}
```

**Response 200:**

```json
{
  "qrCodeBase64": "data:image/png;base64,...",
  "copiaCola": "00020126580014br.gov.bcb.pix...",
  "valor": 142.50,
  "vencimento": "2026-07-15",
  "beneficiario": "Prefeitura Municipal de Brazópolis"
}
```

---

## 8. Busca Global (MeiliSearch)

### 8.1 Pesquisa Unificada

```
GET /public/search?q={termo}&page=1&limit=20
X-App-Key: {app_key}
```

**Response 200:**

```json
{
  "query": "vacina",
  "resultados": [
    {
      "tipo": "saude",
      "titulo": "Campanha de Vacinação contra Gripe",
      "descricao": "Vacinação disponível nas UBS...",
      "rota": "/saude/vacinacao/1",
      "relevancia": 0.95
    },
    {
      "tipo": "noticia",
      "titulo": "Prefeitura inicia vacinação contra gripe",
      "descricao": "A partir de segunda-feira...",
      "rota": "/noticias/vacinacao-gripe-2026",
      "relevancia": 0.87
    },
    {
      "tipo": "evento",
      "titulo": "Dia D de Vacinação",
      "descricao": "Vacinação especial no sábado...",
      "rota": "/eventos/1",
      "relevancia": 0.82
    }
  ],
  "total": 3,
  "tempoMs": 12
}
```

---

## 9. Códigos de Erro

| Código | Significado | Quando |
|--------|-----------|--------|
| 200 | OK | Requisição bem-sucedida |
| 201 | Created | Recurso criado (protocolo) |
| 400 | Bad Request | Validação falhou |
| 401 | Unauthorized | API Key inválida |
| 404 | Not Found | Recurso não encontrado |
| 413 | Payload Too Large | Foto maior que 5MB |
| 415 | Unsupported Media Type | Arquivo não é imagem |
| 429 | Too Many Requests | Rate limit excedido |
| 500 | Internal Server Error | Erro no servidor |

**Formato padrão de erro:**

```json
{
  "statusCode": 400,
  "message": ["campo X é obrigatório", "campo Y é inválido"],
  "error": "Bad Request",
  "timestamp": "2026-06-26T14:30:00Z"
}
```

---

## 10. Paginação

Todas as APIs de listagem seguem o padrão:

**Query parameters:**

| Param | Tipo | Default | Descrição |
|-------|------|---------|-----------|
| `page` | number | 1 | Página atual |
| `limit` | number | 10 | Itens por página (max 50) |
| `sort` | string | createdAt | Campo para ordenação |
| `order` | string | DESC | ASC ou DESC |

**Response:**

```json
{
  "data": [...],
  "meta": {
    "total": 100,
    "page": 1,
    "limit": 10,
    "totalPages": 10
  }
}
```

---

> **Nota:** As APIs existentes (seção 1) já estão documentadas no backend. Este documento foca nas **novas APIs** que precisam ser implementadas para o app. Cada endpoint segue o padrão REST existente do projeto NestJS.
]]>
