import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var vm: PokemonDetailViewModel
    
    init(name: String) {
        _vm = StateObject(wrappedValue: PokemonDetailViewModel(name: name))
    }
    
    // Inicializador do  detailView
    init(viewModel: PokemonDetailViewModel) {
        _vm = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            
            if let d = vm.detail {
                VStack(spacing: 36) {
                    
                    // Imagem com fallback seguro
                    AsyncImage(url: imageURL) { phase in
                        
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 250, height: 250)
                            
                        case .success(let image):
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250)
                            
                        case .failure:
                            Image(systemName: "questionmark")
                                .font(.largeTitle)
                                .frame(width: 150, height: 150)
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    // Nome no corpo da View (Grande e em destaque)
                    Text(d.name.capitalized)
                        .font(.title)
                        .bold()
                    
                    // Tipos
                    HStack {
                        Text("Tipo:")
                            .bold()
                        
                        ForEach(d.types, id: \.slot) { t in
                            Text(t.type.name.capitalized)
                                .tagStyle()
                        }
                    }
                    
                    // Habilidades
                    HStack {
                        
                        Text("Habilidades:")
                            .bold()
                        
                        WrapTags(names: d.abilities.map { $0.ability.name.capitalized })
                    }
                    
                    // Conversão peso e altura
                    HStack {
                        
                        let meters = Double(d.height) / 10.0
                        let kilograms = Double(d.weight) / 10.0
                        
                        Text(String(format: "Altura: %.1f m", meters))
                            .bold()
                        
                        Spacer()
                        
                        Text(String(format: "Peso: %.1f kg", kilograms))
                            .bold()
                    }
                }
                .padding()
                
            } else if vm.isLoading {
                ProgressView("Carregando...")
            } else {
                Text("Erro ao carregar dados!")
            }
        }
        .task { await vm.load() }
    }
    
    // Fallback de imagem
    // O código de imageURL e outras Views auxiliares permanecem os mesmos
    private var imageURL: URL? {
        
        // 1. Sprite padrão
        if let urlString = vm.detail?.sprites.front_default,
           let url = URL(string: urlString) {
            return url
        }
        
        // 2. Sprite Home (HD)
        if let id = vm.detail?.id {
            return URL(string:"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id).png"
            )
        }
        
        return nil
    }
}

// Layout simples para tags
private struct WrapTags: View {
    let names: [String]
    
    var body: some View {
        FlowLayout(items: names) { name in
            Text(name).tagStyle()
        }
    }
}

// Layout de fluxo para embrulhar itens
private struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let items: Data
    let content: (Data.Element) -> Content
    
    init(items: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.items = items
        self.content = content
    }
    
    @State private var totalHeight: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
        .frame(height: totalHeight)
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(Array(items), id: \.self) { item in
                content(item)
                    .alignmentGuide(.leading) { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if item == items.last {
                            width = 0 // último item
                        } else {
                            width -= d.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { _ in
                        let result = height
                        if item == items.last {
                            height = 0 // útimo item
                        }
                        return result
                    }
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geo -> Color in
            let rect = geo.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

#Preview("PokemonDetailView") {
    // Mock do PokemonDetailView preview
    let mock = PokemonDetail(
        id: 25,
        name: "pikachu",
        height: 4, // 0.4 m
        weight: 60, // 6.0 kg
        types: [
            .init(slot: 1, type: .init(name: "electric", url: "https://pokeapi.co/api/v2/type/13/"))
        ],
        abilities: [
            .init(isHidden: false, slot: 1, ability: .init(name: "static", url: "")),
            .init(isHidden: true, slot: 3, ability: .init(name: "lightning-rod", url: ""))
        ],
        sprites: .init(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png")
    )
    
    // Pré-carregamento por uma VM
    let vm = PokemonDetailViewModel(name: mock.name, service: MockDetailService(detail: mock))
    // Definir os dados antes de causar carregamento assíncrono na pré-visualização
    vm.detail = mock
    
    return NavigationView { PokemonDetailView(viewModel: vm) }
}

// Serviço de simulação simples para fornecer os dados de pré-visualização
private final class MockDetailService: PokemonServiceProtocol {
    let detail: PokemonDetail
    init(detail: PokemonDetail) { self.detail = detail }
    func fetchAll(limit: Int) async throws -> [PokemonSummary] { return [] }
    func fetchDetail(for name: String) async throws -> PokemonDetail { detail }
}
