import Foundation

public struct BeerMethod: Codable {
    let mashTemp: [MashTemp]
    let fermentation: Fermentation
    let twist: String?
    
    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation, twist
    }
}

public struct MashTemp: Codable {
    let temp: Temp
    let duration: Int?
}

public struct Temp: Codable {
    let value: Int
    let unit: String
}

public struct Fermentation: Codable {
    let temp: Temp
}
