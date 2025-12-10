import Foundation

final class PokemonService: PokemonServiceProtocol {
    
    private let base = "https://pokeapi.co/api/v2"
    
    func fetchAll(limit: Int = 151) async throws -> [PokemonSummary] {
        guard let url = URL(string: "\(base)/pokemon?limit=\(limit)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let resp = try decoder.decode(PokemonListResponse.self, from: data)
        return resp.results
    }
    
    func fetchDetail(for name: String) async throws -> PokemonDetail {
        guard let url = URL(string: "\(base)/pokemon/\(name)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(PokemonDetail.self, from: data)
    }
}
