# API REST

### Premissas
Utiliza protocolo HTTP, o content-type das requisições e das respostas é application/json

## Cadastro de usuarios

Endpoint: /user
Method: POST

Exemplo de cadastro via curl:

~~~
curl -H "Accept: application/json" -H "Content-Type: application/json" -d "{\"name\":\"danilo\", \"email\":\"danilo.moura.lima@gmail.com\", \"cpf\":\"34121388860\",\"dob\": \"1987-03-11\" }" http://localhost:9292/user -v
~~~

### Parâmetros de entrada
Este request é um POST com Content-Type application/json, o corpo do post é o seguinte JSON:

~~~

{
    "name": "danilo",
    "email": "danilo@uol.com.br",
    "dob": "1987-03-11",
    "cpf": "341.213.888-60"
}

~~~

#### Tabela de parâmetros

| Nome   | Tipo   | Tamanho    | Obrigatório | Descrição                     |
|--------|--------|------------|-------------|-------------------------------|
| name   | String | 100 (Max)  | Sim         | Nome do usuário               |
| email  | String |  80 (Max)  | Sim         | Email do usuário              |
| dob    | Date   |            | Não         | Data de Nascimento do usuário |
| cpf    | String |  8  (Ext)  | Não         | CPF do usuário                |

* Max = máximo
* Ext = exato

### Dados de resposta

#### Status HTTP

| Código           | Descrição                       |
|------------------|---------------------------------|
| 201              | Cadastro efetuado com sucesso   |
| 400              | Parâmetros inválidos            |
| 409              | CNPJ já cadastrado              |
| 500              | Erro interno no servidor        |

#### Exemplo de erro

~~~
  {
    "errors": {
      "name":["is already taken"],"email":["is already taken"]
      }
  }

~~~

## Consulta de todos os usuário

Endpoint: /user
Method: GET

Exemplo de edição via curl:

~~~

curl -X GET http://localhost:9292/user

~~~

#### Status HTTP

| Código           | Descrição                       |
|------------------|---------------------------------|
| 200              | Consulta efetuada com sucesso  |

#### Exemplo de sucesso
[
   {
      "_id":"54047a438ae00404fb000001",
      "cpf":"34121388860",
      "created_at":"2014-09-01T13:53:07Z",
      "dob":"1987-03-11",
      "email":"danilo.moura.lima@gmail.com",
      "name":"danilo",
      "updated_at":"2014-09-01T13:53:07Z"
   },
   {
      "_id":"5407b48a8ae0040236000001",
      "cpf":"34121388860",
      "created_at":"2014-09-04T00:38:34Z",
      "dob":"1987-03-11",
      "email":"anilo.moura.lima@gmail.com",
      "name":"deia",
      "updated_at":"2014-09-04T00:38:34Z"
   }
]


## Consulta de usuário

Endpoint: /user/{ID do usuario}
Method: GET

Exemplo de consulta via curl:

~~~

curl -X GET http://localhost:9292/user/5407b48a8ae0040236000001 -v

~~~

### Parâmetros de entrada
Este request é um GET passando o parâmetro ID na url. O retorno é um JSON com os dados do usuário.

#### Tabela de parâmetros

| Nome | Tipo   | Tamanho  | Obrigatório |
|------|--------|----------|-------------|
| id   | String | 24 (Ext) | Sim         |

* Ext = exato

### Dados de resposta

#### Status HTTP

| Código           | Descrição                       |
|------------------|---------------------------------|
|  200             | Consulta efetuada com sucesso   |
|  404             | Usuário não encontrada           |

#### Exemplo de sucesso

~~~

{
   "_id":"5407b48a8ae0040236000001",
   "cpf":"34121388860",
   "created_at":"2014-09-04T00:38:34Z",
   "dob":"1987-03-11",
   "email":"anilo.moura.lima@gmail.com",
   "name":"deia",
   "updated_at":"2014-09-04T00:38:34Z"
}

~~~

## Cadastro de rede de pontos de entrega

Endpoint: /highway_network
Method: POST

Exemplo de cadastro via curl:

~~~
 curl -H "Accept: application/json" -H "Content-Type: application/json" -d "{\"description\":\"São Paulo ->  Belo Horizonte.\", \"source_point\":\"São Paulo\", \"destination_point\":\"Belo Horizonte\",\"distance\": \"736\" }" http://localhost:9292/highway_network -v
~~~

### Parâmetros de entrada
Este request é um POST com Content-Type application/json, o corpo do post é o seguinte JSON:

~~~

{
  "description": "São Paulo ->  Belo Horizonte.",
  "source_point": "São Paulo",
  "destination_point": "Belo Horizonte",
  "distance": 736
}

~~~

#### Tabela de parâmetros

| Nome              | Tipo    | Tamanho    | Obrigatório | Descrição                        |
|-------------------|---------|------------|-------------|----------------------------------|
| description       | String  | 100 (Max)  | Sim         | Descrição do trecho entre pontos |
| source_point      | String  |            | Sim         | Ponto de Origem                  |
| destination_point | String  |            | Sim         | Potno de Destino                 |
| distance          | Integer |            | Sim         | Distância entre os pontos em KM  |

* Max = máximo

### Dados de resposta

#### Status HTTP

| Código           | Descrição                     |
|------------------|-------------------------------|
| 201              | Cadastro efetuado com sucesso |
| 400              | Parâmetros inválidos          |
| 409              | Já cadastrado                 |

#### Exemplo de erro

~~~
{
    "errors": {
      "description":["is already taken"],
      "source_point":["can't be blank","Origem inválida!!"],
      "destination_point":["can't be blank","Destino inválido!!"]
    }
}
~~~

## Consulta de todos os trechos

Endpoint: /highway_network
Method: GET

Exemplo de edição via curl:

~~~

curl -X GET http://localhost:9292/highway_network

~~~

#### Status HTTP

| Código           | Descrição                       |
|------------------|---------------------------------|
| 200              | Consulta efetuada com sucesso  |

#### Exemplo de sucesso
[
   {
      "_id":"5403a21b8ae0042041000006",
      "created_at":"2014-08-31T22:30:51Z",
      "description":"A -> B",
      "destination_point":{
         "_id":"5403a21b8ae0042041000002",
         "city":"Ribeirão Preto",
         "created_at":"2014-08-31T22:30:51Z",
         "description":"Ribeirão Preto",
         "state":"SP",
         "updated_at":"2014-08-31T22:30:51Z"
      },
      "destination_point_id":"5403a21b8ae0042041000002",
      "distance":207,
      "source_point":{
         "_id":"5403a21b8ae0042041000001",
         "city":"São José do Rio Preto",
         "created_at":"2014-08-31T22:30:51Z",
         "description":"São José do Rio Preto",
         "state":"SP",
         "updated_at":"2014-08-31T22:30:51Z"
      },
      "source_point_id":"5403a21b8ae0042041000001",
      "updated_at":"2014-08-31T22:30:51Z"
   },
   {
      "_id":"5403a21b8ae0042041000007",
      "created_at":"2014-08-31T22:30:51Z",
      "description":"B -> D",
      "destination_point":{
         "_id":"5403a21b8ae0042041000002",
         "city":"Ribeirão Preto",
         "created_at":"2014-08-31T22:30:51Z",
         "description":"Ribeirão Preto",
         "state":"SP",
         "updated_at":"2014-08-31T22:30:51Z"
      },
      "destination_point_id":"5403a21b8ae0042041000002",
      "distance":238,
      "source_point":{
         "_id":"5403a21b8ae0042041000001",
         "city":"São José do Rio Preto",
         "created_at":"2014-08-31T22:30:51Z",
         "description":"São José do Rio Preto",
         "state":"SP",
         "updated_at":"2014-08-31T22:30:51Z"
      },
      "source_point_id":"5403a21b8ae0042041000001",
      "updated_at":"2014-08-31T22:30:51Z"
   }
]

## Consulta de melhor trecho para entrega

Endpoint: /highway_network/best_delivery
Method: GET

Exemplo de cadastro via curl:

~~~
 curl -X GET "http://localhost:9292/highway_network/best_delivery?consumo_caminhao=10&destination_point=Belo+Horizonte&source_point=S%C3%A3o+Paulo&valor_litro=2.30" -v
~~~

### Parâmetros de entrada
Este request é um GET com parametros na URL

~~~

{
  "consumo_caminhao": 10,
  "source_point": "São Paulo",
  "destination_point": "Belo Horizonte",
  "valor_litro": "2.50"
}

~~~

#### Tabela de parâmetros

| Nome              | Tipo    | Tamanho    | Obrigatório | Descrição                        |
|-------------------|---------|------------|-------------|----------------------------------|
| consumo_caminhao  | Integer |            | Sim         | Consumo de combustível           |
| source_point      | String  |            | Sim         | Ponto de Origem                  |
| destination_point | String  |            | Sim         | Ponto de Destino                 |
| valor_litro       | Float   |            | Sim         | Valor do combustível por litro   |

* Max = máximo

### Dados de resposta

#### Status HTTP

| Código           | Descrição                     |
|------------------|-------------------------------|
| 201              | Cadastro efetuado com sucesso |
| 400              | Parâmetros inválidos          |
| 404              | Ponto não encontrado          |
| 409              | Já cadastrado                 |

#### Exemplo de erro

~~~
{
    "errors": {
      "Point not found."
    }
}
~~~
