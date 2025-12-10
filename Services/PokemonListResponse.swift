import Foundation

struct PokemonListResponse: Codable {
    let results: [PokemonSummary]
}
