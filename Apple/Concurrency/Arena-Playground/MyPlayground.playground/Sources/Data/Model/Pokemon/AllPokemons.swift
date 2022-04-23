import Foundation

// MARK: - AllPokemons
public struct AllPokemons: Codable {
  public let count: Int
  public let next, previous: String?
  public let results: [AllPokemonsResult]
}

// MARK: - AllPokemonsResult
public struct AllPokemonsResult: Codable {
  public let name: String
  public let url: String
}

extension AllPokemonsResult {
  public var number: Int? {
    let arr = self.url.components(separatedBy: "/")
    return Int(arr[arr.count - 2]) ?? 0
  }
}
