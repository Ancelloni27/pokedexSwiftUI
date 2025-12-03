import SwiftUI

struct PokemonListView: View {
    @StateObject private var vm = PokemonListViewModel()
    
    var body: some View {
        NavigationView {
            //Usei uma VStack para empilhar o titulo custom e a lista
            VStack() {
                
                //TÍTULO CUSTOMIZADO (Grande e Centralizado)
                HStack {
                    Spacer()
                    Text("Pokedex")
                        .font(.largeTitle.bold())
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // LISTA
                List {
                    ForEach(vm.filtered) { p in
                        NavigationLink(destination: PokemonDetailView(name: p.name)) {
                            PokemonRowView(pokemon: p)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                
            } // Fim do VStack
            
            // OCULTAR TÍTULO NATIVO
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            
            // Outros Modificadores
            .searchable(text: $vm.query, prompt: "Buscar Pokémon")
            .overlay {
                if vm.isLoading {
                    ProgressView("Carregando...")
                }
            }
            .task { await vm.loadAll() }
        }
    }
}

//#Preview e o MockListService

#Preview("PokemonListView") {
    // Mock de alguns Pókemons
    let mockList = [
        PokemonSummary(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
        PokemonSummary(name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/4/"),
        PokemonSummary(name: "squirtle", url: "https://pokeapi.co/api/v2/pokemon/7/")
    ]
    
    //Criar um modelo de visualização e inserir dados
    let vm = PokemonListViewModel(service: MockListService(items: mockList))
    
    return NavigationView { PokemonListView() }
        .environmentObject(vm)
}

// Serviço de lista simulada simples, usa apenas de pré-visualizações
private final class MockListService: PokemonServiceProtocol {
    let items: [PokemonSummary]
    init(items: [PokemonSummary]) { self.items = items }
    func fetchAll(limit: Int) async throws -> [PokemonSummary] { items }
    func fetchDetail(for name: String) async throws -> PokemonDetail { fatalError("Not needed in this preview") }
}
