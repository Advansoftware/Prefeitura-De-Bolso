import json
import urllib.request
import urllib.parse
import urllib.error
import os

API_KEY = os.environ.get('TRELLO_API_KEY', 'SUA_CHAVE_AQUI')
TOKEN = os.environ.get('TRELLO_TOKEN', 'SEU_TOKEN_AQUI')

def do_post(url, data=None, content_type="application/x-www-form-urlencoded"):
    req = urllib.request.Request(url, method="POST")
    if data:
        if content_type == "application/x-www-form-urlencoded":
            data = urllib.parse.urlencode(data).encode('utf-8')
        req.data = data
        req.add_header('Content-Type', content_type)
    
    try:
        response = urllib.request.urlopen(req)
        return json.loads(response.read().decode('utf-8'))
    except urllib.error.HTTPError as e:
        print(f"Erro HTTP {e.code}: {e.read().decode('utf-8')}")
        raise e

def create_board(name):
    url = f'https://api.trello.com/1/boards/?name={urllib.parse.quote(name)}&key={API_KEY}&token={TOKEN}'
    return do_post(url)['id']

def create_list(name, id_board):
    url = f'https://api.trello.com/1/lists?name={urllib.parse.quote(name)}&idBoard={id_board}&key={API_KEY}&token={TOKEN}'
    return do_post(url)['id']

def create_card(name, desc, id_list):
    url = f'https://api.trello.com/1/cards?idList={id_list}&key={API_KEY}&token={TOKEN}'
    # Nome e desc no body para suportar textos longos
    params = {'name': name, 'desc': desc}
    return do_post(url, data=params)['id']

def add_attachment(card_id, file_path):
    if not os.path.exists(file_path):
        print(f"        [!] Arquivo não encontrado: {file_path}")
        return
        
    url = f"https://api.trello.com/1/cards/{card_id}/attachments?key={API_KEY}&token={TOKEN}"
    
    import mimetypes
    import uuid
    boundary = uuid.uuid4().hex
    content_type = f"multipart/form-data; boundary={boundary}"
    
    filename = os.path.basename(file_path)
    mime = mimetypes.guess_type(filename)[0] or 'application/octet-stream'
    
    with open(file_path, 'rb') as f:
        file_content = f.read()
        
    body = bytearray()
    body.extend(f"--{boundary}\r\n".encode('utf-8'))
    body.extend(f'Content-Disposition: form-data; name="file"; filename="{filename}"\r\n'.encode('utf-8'))
    body.extend(f"Content-Type: {mime}\r\n\r\n".encode('utf-8'))
    body.extend(file_content)
    body.extend(f"\r\n--{boundary}--\r\n".encode('utf-8'))
    
    do_post(url, data=bytes(body), content_type=content_type)

def main():
    with open('trello_tasks.json', 'r', encoding='utf-8') as f:
        data = json.load(f)
        
    print(f"Criando quadro: {data['nome_quadro']}...")
    board_id = create_board(data['nome_quadro'])
    print(f"Quadro criado! ID: {board_id}")
    
    for lista in data['listas']:
        print(f"  Criando lista: {lista['nome']}...")
        list_id = create_list(lista['nome'], board_id)
        
        for cartao in lista['cartoes']:
            desc = cartao['descricao']
            if 'etiquetas' in cartao and cartao['etiquetas']:
                desc += "\n\n**Tags:** " + ", ".join(cartao['etiquetas'])
                
            print(f"    Criando cartão: {cartao['titulo']}...")
            card_id = create_card(cartao['titulo'], desc, list_id)
            
            if 'anexos' in cartao and cartao['anexos']:
                for anexo in cartao['anexos']:
                    file_path = os.path.join('mockups', anexo)
                    print(f"      Anexando imagem: {anexo}...")
                    add_attachment(card_id, file_path)
                    
    print("Finalizado com sucesso! Acesse o seu Trello para conferir o quadro.")

if __name__ == '__main__':
    main()
