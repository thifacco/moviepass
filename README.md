![moviepass-logo](https://github.com/thifacco/moviepass-springboot-api/blob/master/schema.db/moviepass.jpg)

# 📽️ MoviePass Spring Boot API

[EM DESENVOLVIMENTO] 

Esse monorepo contém aplicações back e front para solucionar um case de reserva de ingressos de cinema.

- API desenvolvida com Sprint Boot
- Schema DB MySQL com scripts

## Regras de negócio:
- O usuário precisa se cadastrar para poder comprar tíckets.

- No tícket, o usuário escolhe o filme, a sessão e reserva uma cadeira.

- Cada usuário pode comprar diversos tickets para diversas sessões, porém cada ticket pertence a uma única sessão e possui única sala e poderá reservar somente uma cadeira.

- Garantir que o usuário não reserve uma cadeira que já esteja reservada para outro usuário na mesma sessão.

- O tícket só será válido após a confirmação do pagamento e a geração do recibo.

- O recibo armazenará informações do pagamento, como método de pagamento, valor pago e status.

- Somente após a associação de um tícket a um recibo ele será considerado válido para uso.

## Fluxo de Compra
1. O usuário compra o tícket, mas ele ainda não está válido.

2️. Um recibo é gerado com status = 'pending'.

3. Quando o pagamento for confirmado, o status do recibo muda para 'confirmed'.

4️. Apenas tíckets com recibo confirmado são considerados válidos para uso.

## Esquema do banco de dados
![schema-db](https://github.com/thifacco/moviepass-springboot-api/blob/master/schema.db/schema-db-MoviePress.jpg)

## Endpoints

### Usuário
**POST** /user (cria um novo usuário)

### Filme
**POST** /movie (cria um novo filme)

### Sala
**POST** /room (cria uma nova sala)

**POST** /room/addChair (cria uma nova cadeira em uma sala)

### Sessão
**POST** /session (cria uma nova sessão com um filme em uma sala)

### Tícket
**POST** /ticket (cria um ticket para um usuário, em uma sessão e com uma cadeira selecionada)

**POST** /ticket/payment (realiza o pagamento do ticket e cria um novo recibo)

**PATCH** /ticket/payment/confirm (confirma o pagamento do ticket)
   
**GET** /ticket/receipt (visualiza o recibo da compra do ticket)

**GET** /ticket/status (verifica se o ticket é valido para sessão)
