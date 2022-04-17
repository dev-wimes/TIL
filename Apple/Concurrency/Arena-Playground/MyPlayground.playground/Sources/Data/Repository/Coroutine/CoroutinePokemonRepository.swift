import Foundation


public protocol CoroutinePokemonRepository {
  func fetchAllPokemons(limit: Int, offset: Int) async throws -> AllPokemons
  func fetchPokemonInfo(pokemonNumber: Int) async throws -> PokemonInfo
}

public final class CoroutinePokemonRepositoryImpl: CoroutineBaseRepository, CoroutinePokemonRepository {
  
  public override init() { super.init() }
  
  public func fetchAllPokemons(limit: Int, offset: Int) async throws -> AllPokemons{
    let query = PokemonsQ(limit: limit, offset: offset)
    let api = PokemonAPI.allPokemons(q: query)
    
    return try await self.execute(api: api)
  }
  
  public func fetchPokemonInfo(pokemonNumber: Int) async throws -> PokemonInfo{
    let api = PokemonAPI.pokemonInfo(number: pokemonNumber)
    
    return try await self.execute(api: api)
  }
}
