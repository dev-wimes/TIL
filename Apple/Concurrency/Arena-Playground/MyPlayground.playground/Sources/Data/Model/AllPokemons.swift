import Foundation

// MARK: - AllPokemons
struct AllPokemons: Codable {
  let count: Int
  let next, previous: String?
  let results: [AllPokemonsResult]
}

// MARK: - AllPokemonsResult
struct AllPokemonsResult: Codable {
  let name: String
  let url: String
}
