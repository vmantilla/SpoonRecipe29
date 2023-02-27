import Foundation

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let summary: String
    let imageURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case summary
        case imageURL = "image"
    }
    
    static var dummyData: [Recipe] {
        return [
            Recipe(id: 1, title: "Receta 1", summary: "Resumen de la Receta 1", imageURL: nil),
            Recipe(id: 2, title: "Receta 2", summary: "Resumen de la Receta 2", imageURL: nil),
            Recipe(id: 3, title: "Receta 3", summary: "Resumen de la Receta 3", imageURL: nil)
        ]
    }
}

struct SearchResponse: Codable {
    let results: [Recipe]
}
