<![CDATA[# 🔒 Volume 6 — Segurança, Privacidade e LGPD

## Projeto "Prefeitura no Bolso"

| Item | Detalhe |
|------|---------|
| **Princípio Base** | Privacy by Design |
| **Identificação** | App 100% anônimo |
| **Coleta de dados** | Apenas dados essenciais e voluntários |

---

## Sumário

1. [Abordagem "Sem Cadastro"](#1-abordagem-sem-cadastro)
2. [Proteção de Dados no App (Mobile)](#2-proteção-de-dados-no-app-mobile)
3. [Proteção de Dados no Trânsito](#3-proteção-de-dados-no-trânsito)
4. [Proteção de Dados no Servidor](#4-proteção-de-dados-no-servidor)
5. [Privacidade de Localização (GPS)](#5-privacidade-de-localização-gps)
6. [Adequação à LGPD](#6-adequação-à-lgpd)

---

## 1. Abordagem "Sem Cadastro"

O "Prefeitura no Bolso" resolve o maior gargalo de adoção de apps governamentais eliminando completamente a barreira de entrada: **o login**.

### 1.1 O que NÃO coletamos
- Nome
- CPF
- Email
- Senha
- Data de nascimento
- Endereço residencial (exceto quando informado voluntariamente em protocolos)
- Número de telefone

### 1.2 Como identificamos os dispositivos
Para permitir notificações e rastreamento local de protocolos, usamos identificadores efêmeros e pseudonimizados:
- **Token FCM (Firebase Cloud Messaging):** String gerada pelo Google/Apple, usada apenas para envio de push. Não contém identidade.
- **Chave de Protocolo:** Senha gerada aleatoriamente (ex: `FT42B`) e salva no dispositivo do usuário, que prova a propriedade sobre um protocolo sem precisar de conta.

---

## 2. Proteção de Dados no App (Mobile)

### 2.1 Armazenamento Local Seguro
O app salva informações no dispositivo (cache, histórico de protocolos, inscrições de IPTU favoritas, bairros de interesse).
- **SQLite (Protocolos salvos):** Contém os números e chaves dos protocolos abertos. Não contém PII (Personally Identifiable Information).
- **SharedPreferences / NSUserDefaults:** Guarda preferências (ex: "Receber alerta de IPTU", "Bairro: Centro").
- **Flutter Secure Storage:** Caso haja necessidade futura de armazenar tokens de sessão ou chaves privadas.

### 2.2 Limpeza de Dados
A tela de **Configurações** possui um botão **"Limpar todos os dados"**.
- Ao tocar, o app apaga: banco SQLite local, cache de imagens, cache de API e preferências.
- O app volta ao estado original "zero", de primeira instalação.

### 2.3 Permissões do SO (Android/iOS)
As permissões são solicitadas no modo **Just-in-Time** (apenas quando necessárias), com explicação clara (Rationale):
- **Câmera:** "Precisamos da câmera para você tirar uma foto do problema a ser reportado." (Usada apenas em protocolos).
- **Localização:** "Precisamos da sua localização para mapear onde está o problema ou mostrar os pontos mais próximos." (Pode ser recusada; o usuário pode digitar o endereço).
- **Notificações:** "Deseja receber alertas da prefeitura?" (No Android 13+ e iOS).

---

## 3. Proteção de Dados no Trânsito

- **TLS/SSL Obrigatório (HTTPS):** Toda comunicação entre o app Flutter e a API NestJS ocorre via HTTPS (TLS 1.2 ou superior). Nenhuma rota HTTP pura é permitida.
- **Certificate Pinning (Recomendado):** Para evitar ataques de Man-in-the-Middle (MitM) em redes públicas, o app pode pinar o certificado público da API.
- **Deep Links Seguros:** A comunicação com o WhatsApp usa a URL oficial `https://wa.me/`, delegando a segurança ao app do WhatsApp.

---

## 4. Proteção de Dados no Servidor

O backend existente em NestJS já possui regras de segurança estabelecidas, que devem ser estendidas:

### 4.1 Validação e Sanitização
- **Pipes do NestJS (class-validator):** Todas as entradas de DTOs públicas são validadas estritamente. Strings com limite de tamanho, números em faixas permitidas.
- **Upload de Arquivos (Fotos):**
  - Checagem de tipo MIME estrita (apenas `image/jpeg` e `image/png`).
  - Limite de tamanho (ex: 5MB).
  - Escaneamento básico de conteúdo malicioso / re-encodificação da imagem antes de salvar no MinIO.

### 4.2 Rate Limiting e Anti-Spam
Como a API é pública e não tem login, ela é vulnerável a spam.
- **Throttler (NestJS):** Restrição rígida por IP.
  - Endpoints de leitura (GET): 100 requisições por minuto.
  - Criação de Protocolos (POST): 10 protocolos por hora por IP.
- **Captcha Invisível / Device Attestation:** (Implementação futura caso necessário) uso do reCAPTCHA v3 Enterprise ou Google Play Integrity / Apple DeviceCheck para bloquear bots automatizados.

### 4.3 MinIO e URLs Assinadas
As fotos de protocolos ficam em um bucket do MinIO.
- O bucket é **privado**.
- O admin gera **URLs pre-signed** de curta duração (ex: 1 hora) caso precise ver a foto em alta resolução, limitando a exposição.
- Fotos exibidas no app são versões de thumbnail compactadas (baixa resolução).

### 4.4 Hashes
A "chave" secreta do protocolo (`FT42B`) não deve ser salva em texto puro no banco de dados.
- O servidor usa `bcrypt` para gerar um hash da chave antes de salvar.
- Quando o usuário consulta, o servidor faz o `compare` do hash, igual a uma senha tradicional.

---

## 5. Privacidade de Localização (GPS)

O app trabalha com dados de geolocalização.

### 5.1 Protocolos
Quando o cidadão abre um protocolo:
- A coordenada (Lat/Lng) enviada reflete a **posição do problema (ex: buraco)**, e não do usuário.
- O dado é pontual (one-time). O app **não rastreia** o usuário em background.

### 5.2 Mapa Inteligente e Turismo
- A localização é processada **apenas localmente** (no celular) para calcular distâncias (ex: "A UBS está a 500m de você").
- As coordenadas não são enviadas para a API nessas telas.

---

## 6. Adequação à LGPD

### 6.1 Consentimento
O onboarding inclui links para a **Política de Privacidade** e **Termos de Uso**. Continuar o uso do app implica consentimento para os termos básicos.

### 6.2 Minimização
O princípio da minimização é aplicado ao extremo: se não precisamos do nome da pessoa para tapar um buraco, não pedimos o nome da pessoa.

### 6.3 Dados de Saúde
A visualização de dados do SUS, agendamento de consultas ou prontuários médicos (dados sensíveis) **NÃO** estão no escopo deste app aberto. Módulos desse tipo exigiriam integração com o sistema Gov.br (Ouro/Prata). O módulo "Saúde" do app restringe-se a informações públicas: horários de postos, campanhas gerais e telefones.

### 6.4 Direito de Exclusão
Como não há conta atrelada a uma pessoa, a exclusão dos dados (FCM Token, histórico local) se dá pela **desinstalação do aplicativo** ou limpeza de dados nas configurações, efetivando o "direito de ser esquecido".
]]>
