import SwiftUI

enum DS {
    //Spacing
    enum Spacing {
        static let sm: CGFloat = 6
    }
    
    //Corner radius
    enum Radius {
        static let md: CGFloat = 32
    }
    
    //Cores
    enum Color {
        static let cardBackground = SwiftUI.Color(.systemBackground)
        static let tagBackground = SwiftUI.Color(.tertiarySystemFill)
        static let placeholder = SwiftUI.Color.secondary
    }
    
    //Modificadores comuns dos cards de info
    struct Card: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(Spacing.sm)
                .background(.thinMaterial)
                .cornerRadius(Radius.md)
        }
    }
    
    struct Tag: ViewModifier {
        func body(content: Content) -> some View {
            content
                .background(.thinMaterial)
        }
    }
}

extension View {
    func cardStyle() -> some View { modifier(DS.Card()) }
    func tagStyle() -> some View { modifier(DS.Tag()) }
}
