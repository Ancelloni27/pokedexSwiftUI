import Foundation

protocol PokemonServiceProtocol {
    func fetchAll(limit: Int) async throws -> [PokemonSummary]
    func fetchDetail(for name: String) async throws -> PokemonDetail
}
