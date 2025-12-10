import Foundation
import SwiftUI
import Combine

@MainActor
final class PokemonListViewModel: ObservableObject {
    @Published private(set) var pokemons: [PokemonSummary] = []
    @Published var query: String = ""
    @Published var isLoading = false
    
    private let service: PokemonServiceProtocol
    
    init(service: PokemonServiceProtocol? = nil) {
        self.service = service ?? PokemonService()
    }
    
    var filtered: [PokemonSummary] {
        guard !query.isEmpty else { return pokemons }
        return pokemons.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
    
    func loadAll() async {
        isLoading = true
        defer { isLoading = false }
        do {
            pokemons = try await service.fetchAll(limit: 151)
        } catch {
            print("Erro ao carregar pokemons:", error)
        }
    }
}
