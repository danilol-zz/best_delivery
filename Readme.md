#site
EU como usuário do sistema
QUERO me cadastrar
PARA poder utilizar o site

EU como usuário do sistema
QUERO cadastrar as minhas rotas
PARA poder manter o realizar entregas até elas

EU como usuário do sistema
QUERO saber qual a rota mais econômica
PARA realizar minhas entregas


#GingaOne - Prova - Processo Seletivo Walmart

## .: Entregando mercadorias

O Walmart esta desenvolvendo um novo sistema de logistica e sua ajuda é muito importante neste momento. Sua tarefa será desenvolver o novo sistema de entregas visando sempre o menor custo. Para popular sua base de dados o sistema precisa expor um Webservices que aceite o formato de malha logística (exemplo abaixo), nesta mesma requisição o requisitante deverá informar um nome para este mapa. É importante que os mapas sejam persistidos para evitar que a cada novo deploy todas as informações desapareçam. O formato de malha logística é bastante simples, cada linha mostra uma rota: ponto de origem, ponto de destino e distância entre os pontos em quilômetros.


### Mapa 1 - Interior SP
A = São José do Rio Preto
B = Ribeirão Preto
C = Araraquara
D = Lins
E = Araçatuba

A B 207
B D 238
A C 170
C D 201
B E 327
D E 94

### Mapa 2 - Centro Brasil
A = Brasília
B = Belo Horizonte
C = Rio de Janeiro
D = São Paulo
E = Goiânia

A B 736
B D 585
A C 1162
C D 432
B E 873
D E 929

### Mapa 3 - Nordeste
A = Fortaleza - CE
B = Natal - RN
C = Recife - PE
D = Petrolina - PE
E = Teresina - PI

A B 522
B D 858
A C 754
C D 714
B E 1027
D E 635

Com os mapas carregados o requisitante irá procurar o menor valor de entrega e seu caminho, para isso ele passará o mapa, nome do ponto de origem, nome do ponto de destino, autonomia do caminhão (km/l) e o valor do litro do combustivel, agora sua tarefa é criar este Webservices. Um exemplo de entrada seria, mapa SP, origem A, destino D, autonomia 10, valor do litro 2,50; a resposta seria a rota A B D com custo de 6,25.

Voce está livre para definir a melhor arquitetura e tecnologias para solucionar este desafio, mas não se esqueça de contar sua motivação no arquivo README que deve acompanhar sua solução, junto com os detalhes de como executar seu programa. Documentação e testes serão avaliados também =) Lembre-se de que iremos executar seu código com malhas beeemm mais complexas, por isso é importante pensar em requisitos não funcionais também!!

Também gostariamos de acompanhar o desenvolvimento da sua aplicação através do código fonte. Por isso, solicitamos a criação de um repositório que seja compartilhado com a gente. Para o desenvolvimento desse sistema, nós solicitamos que você utilize a sua (ou as suas) linguagem de programação principal. Pode ser Java, JavaScript ou Ruby.

Nós solicitamos que você trabalhe no desenvolvimento desse sistema sozinho e não divulgue a solução desse problema pela internet. O prazo máximo para entrega é dia 03/09.

bom desafio!
