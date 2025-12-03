import SwiftUI

struct PokemonRowView: View {
    let pokemon: PokemonSummary
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: iconURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 56, height: 56)
                case .success(let image):
                    image.resizable().scaledToFit().frame(width: 62, height: 62)
                case .failure:
                    
                    Image(systemName: "questionmark")
                        .frame(width: 56, height: 56)
                    
                default:
                    EmptyView()
                }
            }
            
            Text(pokemon.name.capitalized)
                .font(.default .bold())
            
            Spacer()
            
        }
        .cardStyle()
    }
    
    private var iconURL: URL? {
        let id = pokemon.id // Certificar-se de que PokemonSummary tem um 'id'
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
}


#Preview("PokemonRowView", traits: .sizeThatFitsLayout) {
    let sample = PokemonSummary(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
    return PokemonRowView(pokemon: sample)
        .padding()
}
