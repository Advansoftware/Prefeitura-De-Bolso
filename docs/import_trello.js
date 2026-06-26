const fs = require('fs');
const path = require('path');
const axios = require('axios');
const FormData = require('form-data');

const API_KEY = process.env.TRELLO_API_KEY || 'SUA_CHAVE_AQUI';
const TOKEN = process.env.TRELLO_TOKEN || 'SEU_TOKEN_AQUI';

const dataPath = path.join(__dirname, 'trello_tasks.json');
const data = JSON.parse(fs.readFileSync(dataPath, 'utf8'));

async function createBoard(name) {
  const res = await axios.post(`https://api.trello.com/1/boards/`, null, {
    params: { name, key: API_KEY, token: TOKEN }
  });
  return res.data.id;
}

async function createList(name, idBoard) {
  const res = await axios.post(`https://api.trello.com/1/lists`, null, {
    params: { name, idBoard, key: API_KEY, token: TOKEN }
  });
  return res.data.id;
}

async function createCard(name, desc, idList) {
  const res = await axios.post(`https://api.trello.com/1/cards`, null, {
    params: { name, desc, idList, key: API_KEY, token: TOKEN }
  });
  return res.data.id;
}

async function addAttachment(cardId, filePath) {
  if (!fs.existsSync(filePath)) {
    console.log(`        [!] Arquivo não encontrado: ${filePath}`);
    return;
  }
  const formData = new FormData();
  formData.append('key', API_KEY);
  formData.append('token', TOKEN);
  formData.append('file', fs.createReadStream(filePath));
  
  try {
    await axios.post(`https://api.trello.com/1/cards/${cardId}/attachments`, formData, {
      headers: formData.getHeaders()
    });
  } catch (err) {
    console.error(`        [!] Erro ao anexar ${filePath}: ${err.message}`);
  }
}

async function main() {
  try {
    console.log(`Criando quadro: ${data.nome_quadro}...`);
    const boardId = await createBoard(data.nome_quadro);
    console.log(`Quadro criado! ID: ${boardId}`);

    for (const lista of data.listas) {
      console.log(`  Criando lista: ${lista.nome}...`);
      const listId = await createList(lista.nome, boardId);

      for (const cartao of lista.cartoes) {
        let desc = cartao.descricao;
        if (cartao.etiquetas && cartao.etiquetas.length > 0) {
          desc += `\n\n**Tags:** ${cartao.etiquetas.join(', ')}`;
        }

        console.log(`    Criando cartão: ${cartao.titulo}...`);
        const cardId = await createCard(cartao.titulo, desc, listId);

        if (cartao.anexos && cartao.anexos.length > 0) {
          for (const anexo of cartao.anexos) {
            const filePath = path.join(__dirname, 'mockups', anexo);
            console.log(`      Anexando imagem: ${anexo}...`);
            await addAttachment(cardId, filePath);
          }
        }
      }
    }
    console.log('Finalizado com sucesso! Acesse o seu Trello para conferir o quadro.');
  } catch (err) {
    console.error('Erro geral:', err.response ? err.response.data : err.message);
  }
}

main();
