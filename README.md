Pokédex em SwiftUI:


Olá! Este é o repositório do projeto Pokédex construído inteiramente usando SwiftUI. O objetivo é criar uma aplicação nativa para iOS que permite aos usuários visualizar informações detalhadas sobre diferentes Pokémon.


Visão Geral do Projeto:


Este projeto é uma Pokédex digital focada em demonstrar habilidades com SwiftUI, a nova framework declarativa da Apple para construção de interfaces de usuário.


Funcionalidades Principais:


Uma lista de Pokémon que exibe uma lista de Pokémon com seus nomes e números.
Detalhes do Pokémon: Ao tocar em um item da lista, é exibida uma tela com informações como:
* Imagens oficiais;
* Tipo(s) (Ex: Grass, Poison);
* Estatísticas (HP, Ataque, Defesa, etc.);
* Consumo de API: Os dados dos Pokémon são buscados de uma API externa (provavelmente a PokeAPI).


Tecnologias Utilizadas:


* Swift: Linguagem de programação da Apple.
* SwiftUI: Para construção de toda a interface do usuário e navegação.
* Combine: Framework utilizado para lidar com chamadas de rede (API) e atualizações de dados de forma reativa.
* API Externa: Utiliza dados públicos para buscar informações dos Pokémon.


Como Rodar o Projeto:


Para visualizar e testar o projeto, você precisará ter o ambiente de desenvolvimento da Apple configurado.


Requisitos:


* MacOS (com Xcode instalado).
* Xcode 14 ou superior.
* Swift 5.7 ou superior.


Clone o Repositório: Abra o Terminal e execute o comando:


    Bash
    
    git clone https://github.com/Ancelloni27/pokedexSwiftUI.git


Abra no Xcode:


    Bash
    
    cd pokedexSwiftUI
    open Pokedex.xcodeproj


Execute: Selecione um simulador (iPhone) e clique no botão "Run" (o ícone de ▶️) no Xcode.
