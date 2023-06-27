# **Projeto Caronaê 🚕**

Projeto desenvolvido para a matéria de Programação para Dispositivos Móveis, ministrada pelo Prof. Diego Antunes. Tendo como objetivo a implementação de um aplicativo de caronas para os estudantes da UTFPR-PG, utilizando a linguagem Dart e o framework Flutter.

## Membros e suas contribuições 📝

- **[Ana Julia Ribeiro](https://github.com/anajuliaribeiro)** - Desenvolvimento das telas: StartApp, Login, Register e ResetPassword. Navegação entre as telas. Criação dos componentes User e Ride. Estudo e entendimento do Firebase. Estudo e implementação de recursos nativos do dispositivo móvel.

- **[Ricardo Rebelo Junior](https://github.com/Rebel0R)**- Desenvolvimento das telas: SearchRide, OfferRide, MyPerfil, My Rides e Feed. Validação dos dados e feedback de erros. Compartilhamento de dados entre páginas utilizando Provider, e cadastro de novas corridas em uma Lista de Corridas pré-cadastradas. Elaboração da identidade visual do Aplicativo e prototipação das telas. Estudo e implementação do SQLite. Utilização da API climática **Weatherbi**.

## Sobre a API Weatherbi 🌤

Essa API pode ser acessada através do link: https://www.weatherbit.io/
Ela oferece, com base na latitude e longitude informadas na url da requisição, dados como: temperatura, preciptação, velocidade do vento, sensação térmica e etc.

## Diga X 📷

A captura de imagens, utilizando o recurso nativo do dispositivo, foi realizada através do **image_picker**

## Instalação do projeto 💻

Com base neste repositório, tendo o Flutter instalado em sua máquina e o AndroidStudio, execute este comando no _Git Bash_:

```bash
  git clone git@github.com:Rebel0R/project_CaronaeUTFPR.git
```

Após a clonagem do repositório, com o VSCode aberto ou no próprio terminal PowerShell, e o emulador Android ativo, execute o comando:

```bash
  flutter run
```

Versão do Flutter e Dart utilizadas

```bash
  Flutter 3.7.10
  Dart  2.19.7
```

## Dependências Utilizadas 📜

Para realizar a passagem de dados de uma tela, adicioná-los em uma lista de Corridas, e permitir que a lista fosse carregada na tela Feed, a dependência **Provider** foi utilizada.

```bash
dependencies:
  flutter:
    sdk: flutter
  provider: ^5.0.0
  cupertino_icons: ^1.0.2
  sqflite: ^2.2.8+4
  intl: ^0.18.1
  http: ^0.13.6
  image_picker: ^1.0.0
```

Sua instalação foi realizada no arquivo: **pubspec.yaml**.

Seguida pela execução deste comando no terminal:

```bash
flutter packages get
```

## Bugs 🕷

Até o momento da etapa de desenvolvimento, nenhum bug foi encontrado.

## Funcionalidades Não Implementadas 😕

Durante a primeira parte do projeto, as funcionalidades não implementadas são:

- ~~Exibição das caronas criadas pelo usuário na página MyRides.~~

- Implementação da transição dos possíveis estados de uma carona (aceita ou recusada). Quando um usuário reservar uma carona um alerta deverá chegar para o outro usuário que ofereceu a mesma, permitindo que ele decida se irá aceitá-lo ou não.

- ~~Envio de uma imagem para a foto de perfil, dentro da tela MyPerfil.~~

Durante a segunda parte do projeto, as funcionalidades não implementadas são:

- Implementação da transição dos possíveis estados de uma carona (aceita ou recusada). Quando um usuário reservar uma carona um alerta deverá chegar para o outro usuário que ofereceu a mesma, permitindo que ele decida se irá aceitá-lo ou não.

- Utilização do banco de dados Firebase.

- ~~Envio de uma imagem para a foto de perfil, dentro da tela MyPerfil.~~

Ao final desse projeto, a terceira parte do projeto, as funcionalidades não implementadas são:

- Implementação da transição dos possíveis estados de uma carona (aceita ou recusada). Quando um usuário reservar uma carona um alerta deverá chegar para o outro usuário que ofereceu a mesma, permitindo que ele decida se irá aceitá-lo ou não.

- Utilização do banco de dados Firebase.
