import Foundation

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [TypeEntry]
    let abilities: [AbilityEntry]
    let sprites: SpriteContainer
    
    struct TypeEntry: Codable {
        let slot: Int
        let type: NamedURL
    }
    
    struct AbilityEntry: Codable {
        let isHidden: Bool?
        let slot: Int?
        let ability: NamedURL
    }
    
    struct NamedURL: Codable {
        let name: String
        let url: String
    }
    
    struct SpriteContainer: Codable {
        let front_default: String?
    }
}
