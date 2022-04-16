import Foundation

enum PokemonAPI {
  case allPokemons(q: PokemonsQ)
  case pokemonInfo(number: Int)
}

extension PokemonAPI: BaseTargetType {
  var baseURL: String {
    "https://pokeapi.co"
  }
  
  var queryParameter: [String : Any]? {
    switch self {
    case .allPokemons(let q):
      return ["limit": q.limit, "offset": q.offset]
    case .pokemonInfo:
      return [:]
    }
  }
  
  var path: String {
    switch self {
    case .allPokemons:
      return "/api/v2/pokemon"
    case .pokemonInfo(let number):
      return "/api/v2/pokemon/\(number)"
    }
  }
  
  var requestBody: Data? {
    switch self {
    default:
      return nil
    }
  }
  
  var method: Method {
    switch self {
    default:
      return .get
    }
  }
}
