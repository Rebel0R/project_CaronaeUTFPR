
# **Projeto Caronaê 🚕**


Projeto desenvolvido para a matéria de Programação para Dispositivos Móveis, ministrada pelo Prof. Diego Antunes. Tendo como objetivo a implementação de um aplicativo de caronas para os estudantes da UTFPR-PG, utilizando a linguagem Dart e o framework Flutter.


## Membros e suas contribuições 📝

- **[Ana Julia Ribeiro](https://github.com/anajuliaribeiro)**  - Desenvolvimento das telas: StartApp, Login, Register e ResetPassword. Navegação entre as telas. Criação dos componentes User e Ride.

- **[Ricardo Rebelo Junior](https://github.com/Rebel0R)**-  Desenvolvimento das telas: SearchRide, OfferRide, MyPerfil, My Rides e Feed. Validação dos dados e feedback de erros. Compartilhamento de dados entre páginas utilizando Provider, e cadastro de novas corridas em uma Lista de Corridas pré-cadastradas. Elaboração da identidade visual do Aplicativo e prototipação das telas.


## Instalação do projeto 💻

Com base neste repositório, tendo o Flutter instalando em sua máquina e o AndroidStudio, execute este comando no *Git Bash*:

```bash
  git clone 'caminho do repositório'
```

Após a clonagem do repositório, com o VSCode aberto eou no próprio terminal PowerShell, e o emulador Android ativo, execute o comando:
```bash
  flutter run
```



## Dependências Utilizadas 📜

Para realizar a passagem de dados de uma tela, e adicioná-los em uma lista de Corridas, e permitir que a lista fosse carregada na tela Feed, a dependência **Provider** foi utilizada.

```bash
provider: ^5.0.0
```

Sua instalação foi realizada no arquivo: **pubspec.yaml**.

```bash
dependencies:
  flutter:
    sdk: flutter
  provider: ^5.0.0
```

Seguida pela execução deste comando no terminal:
```bash
flutter packages get 
```
## Bugs 🕷

Até o atual momento da fase de denvolvimento do projeto Caronaê nenhum bug foi encontrado.


## Funcionalidades Não Implementadas 😕
Durante a primeira parte do projeto, as funcionalides não implementadas são:

- Exibição das caronas reservadas por um usuário, ou seja, dentro da tela de Caronas não existe apresentação das caronas selecionadas pelo usuário.

- Implementação da transição dos possíveis estados de uma carona (aceita ou recusada). Quando um usuário reservar uma carona um alerta deverá chegar para o outro usuário que ofereceu a mesma, permitindo que ele decida se irá aceitá-lo ou não.

- Envio de uma imagem para a foto de perfil, dentro da tela MyPerfil.

