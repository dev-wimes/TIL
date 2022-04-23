import Foundation

public struct Ingredients: Codable {
    let malt: [Malt]
    let hops: [Hops]
    let yeast: String
}

public struct Malt: Codable {
    let name: String
    let amount: Amount
}

public struct Amount: Codable {
    let value: Double
    let unit: String
}

public struct Hops: Codable {
    let name: String
    let amount: Amount
    let add: String
    let attribute: String
}
