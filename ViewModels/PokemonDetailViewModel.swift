import Foundation
import SwiftUI
import Combine

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published var detail: PokemonDetail?
    @Published var isLoading = false
    
    private let service: PokemonServiceProtocol
    private let name: String
    
    init(name: String, service: PokemonServiceProtocol) {
        self.name = name
        self.service = service
    }
    
    convenience init(name: String) {
        self.init(name: name, service: PokemonService())
    }
    
    func load() async {
        isLoading = true
        defer { isLoading = false }
        do {
            detail = try await service.fetchDetail(for: name)
        } catch {
            print("Erro detail:", error)
        }
    }
}

