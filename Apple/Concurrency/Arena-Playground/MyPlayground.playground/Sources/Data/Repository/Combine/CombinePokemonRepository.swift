import Combine

public protocol CombinePokemonRepository {
  func fetchAllPokemons(limit: Int, offset: Int) -> AnyPublisher<AllPokemons, NetworkError>
  func fetchPokemonInfo(pokemonNumber: Int) -> AnyPublisher<PokemonInfo, NetworkError>
}

public final class CombinePokemonRepositoryImpl: CombineBaseRepository, CombinePokemonRepository {
  public override init() { super.init() }
  
  public func fetchAllPokemons(limit: Int, offset: Int) -> AnyPublisher<AllPokemons, NetworkError> {
    let query = PokemonsQ(limit: limit, offset: offset)
    
    let api = PokemonAPI.allPokemons(q: query)
    return self.execute(api: api)
  }
  
  public func fetchPokemonInfo(pokemonNumber: Int) -> AnyPublisher<PokemonInfo, NetworkError> {
    let api = PokemonAPI.pokemonInfo(number: pokemonNumber)
    return self.execute(api: api)
  }
}
