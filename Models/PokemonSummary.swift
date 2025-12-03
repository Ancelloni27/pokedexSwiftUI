import Foundation
import SwiftUI
import UIKit

struct PokemonSummary: Identifiable, Codable {
    var id: Int {
        Int(url.split(separator: "/").last ?? "0") ?? 0
    }
    
    let name: String
    let url: String
}
