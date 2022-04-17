import RxSwift

public protocol RxPokemonRepository {
  func fetchAllPokemons(limit: Int, offset: Int) -> Observable<AllPokemons>
  func fetchPokemonInfo(pokemonNumber: Int) -> Observable<PokemonInfo>
}

public final class RxPokemonRepositoryImpl: RxBaseRepository, RxPokemonRepository {
  public override init() { super.init() }
  
  public func fetchAllPokemons(limit: Int, offset: Int) -> Observable<AllPokemons> {
    let query = PokemonsQ(limit: limit, offset: offset)
    
    let api = PokemonAPI.allPokemons(q: query)
    return self.execute(api: api)
  }
  
  public func fetchPokemonInfo(pokemonNumber: Int) -> Observable<PokemonInfo> {
    let api = PokemonAPI.pokemonInfo(number: pokemonNumber)
    return self.execute(api: api)
  }
}

