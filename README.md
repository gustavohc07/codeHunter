# CodeHunter Project

Tempo para completar funcionalidades básicas: ~60 horas (medido com o wakatime)

##### Projeto realizado individualmente como etapa do treinamento da [CampusCode](https://www.campuscode.com.br/).

### Gems e versões utilizadas

`ruby 2.6.3`

`rails 6.0.2.1`

`rspec-rails 3.9`

A gem `devise` foi utilizada como forma de autenticação e autorização. Foi utilizado a gem `simplecov` para
verificar a cobertura de testes do projeto.

Por enquanto, para estilizar a plataforma, foi utilizado o Bulma, porém, há diversas melhorias ainda a serem realizadas
e possívelmente haverá migração do Bulma para o Bootstrap.

### Executando o projeto

Para executar o projeto você deve possuir a versão 2.6.3 instalada e o rails instalado. Após isso execute:

`bundle install`

Em seguida execute:

`rails db:migrate` (cria o banco de dados)

`rails server`

Após isso visite `localhost:3000` e será possível visualizar o projeto.

Caso queira rodar os testes, basta executar `rspec` - lembrando que deve-se executar o comando `bundle install` para instalar
a gem `rspec`

### CodeHunters


CodeHunter é uma plataforma de busca de vagas onde haverão os recrutadores,
chamados de CodeHunters, e os candidatos, chamados de Coders.

O usuário poderá se registrar tanto como CodeHunter quanto como um Coder e possuirá diferentes privilégios dentro da plataforma.

Os CodeHunters poderão registrar novas vagas, ver o número de candidatos para cada vaga listada, ver os candidatos que aplicaram
para a vaga em questão, enviar proposta para os candidatos, destacar perfis (haverá melhorias visuais nesse ponto), rejeitar candidatos,
enviar mensagem na aplicação de cada candidato e enviar feedback para os candidatos que não foram aceitos.

Os Coders poderão visualizar as vagas listadas, aplicar para uma vaga caso o seu perfil esteja completo, criar e editar perfil, visualizar as propostas recebidas, caso haja alguma,
aceitar ou rejeitar propostas e recebe feedback do recrutador.

