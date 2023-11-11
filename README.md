# Target Sistemas Challenge

Repositório referente ao desafio de mobile da Target Sistemas.

  O desafio foi feito utilizando Flutter como tecnologia exigida. 


# Decisões arquiteturais, conceitos e premissas

  Para o gerenciamento de estados e da lógica do sistema como um todo foi utilizado o Mobx, onde cada store tem uma responsabilidade única. Nesse caso, foram definidas 3 stores, uma para o login, uma para a entidade Note e outra para a listagem de Notes onde cada estado reativo é definido pelo decorator Observable, cada método responsável por alterações nesse estados são definidos com o decorator Action. Como a store é definida em uma classe abstrata, ela não pode ser instanciadas, apenas definem o comportamento o padrão daquela store. Para isso, criei Mixins para juntar as 2 classes de cada store em uma só, fornecendo ao aplicativo um único acesso para aquela store, com a invocação de seus métodos e utilização de estados.

  Em relação às boas práticas, como cada store tem suas devidas atribuições únicas, o princípio da responsabilidade única é mantido nesse caso. Como não foi preciso injetar uma Store dentro de outra, não vi necessidade de criar interfaces nesse caso com o intuito de desacoplamento.

  Além disso, a única entidade utilizada nas stores e na lógica como um todo é a note_model definidas nos Models. Como o intuito da tela de login era a validação dos campos e redirecionamento para a tela de listagem, caso a validação seja feita corretamente. Optei por não criar models para a tela de Login. Porém, a lógica de validações dos campos do Login também foi feita utilizando Mobx.

  Os métodos de leitura e salvamento dos dados no cache utilizando SharedPreferences foram feitos no próprio widget de listagem de notas. Caso optasse por criar uma api externa, separaria os métodos resposáveis pelas requisições e armazenamento em cache em Services. Mas como foram utilizados poucos métodos para comunicação com a entidade SharedPreferences decidi por inserir eles no próprio widget de listagem.

  Se tratando do aplicativo, na tela de Login foram feitas as validações para cada caso definido nos requisitos do Desafio, uma vez que os campos sejam preenchidos de forma correta, o usuário é redirecionado para a tela de listagem de notas, onde é feito basicamente um CRUD. É possível criar um novo texto, editar, excluir e visualizar a listagem dos textos. Foram inseridos dois botões de adicionar e editar para diferenciar a utilização do input de texto. Todas as informações são armazenadas no cache local por meio do uso da lib shared_preferences, dessa forma, quando o usuário bloqueia a tela ou sai do aplicativo e entra novamente, os dados permanecem lá, como pode ser visualizado no vídeo de desmontração abaixo.

 # Como rodar a aplicação
  
  - É necessário instalar o [Flutter](https://docs.flutter.dev/get-started/install)  e o [Dart](https://dart.dev/get-dart)
        Dart utilizado: 3.2.0
        Flutter utilizado: 3.13.0

  - É preciso instalar o [Android Studio](https://developer.android.com/studio) também

  Após instalar, rodar os comandos:

- Entrar na pasta da raiz do projeto e rodar o seguinte comando para instalar todas as dependências

```
  flutter pub get

```

- Rodar a aplicação: 

```
  flutter run

```

# Rodando a aplicação

Aqui está um vídeo demonstrativo da aplicação:

https://github.com/renanmdreis45/target_challenge/assets/85807389/52d18da2-0c85-4ab7-a68e-10164a4a157c

# Melhorias Futuras

No store do login foi criado alguns métodos para uma autenticação futura do usuário. Além disso, irei implementar alguns testes unitários, principalmente nos métodos das stores.

# Considerações finais
Foi um projeto bom para aplicar conhecimentos do gerenciador de estados Mobx, até então tinha mais afinidade com o gerenciador de estados Bloc, então foi bastante proveitoso para eu me aprofundar nos conceitos e no fluxo do Mobx, ao qual considero bem intuitivo para aprender.
