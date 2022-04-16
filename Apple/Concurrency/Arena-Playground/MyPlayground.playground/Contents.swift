// Playground generated with 🏟 Arena (https://github.com/finestructure/arena)
// ℹ️ If running the playground fails with an error "no such module ..."
//    go to Product -> Build to re-trigger building the SPM package.
// ℹ️ Please restart Xcode if autocomplete is not working.

import RxSwift
import RxRelay
import _Concurrency

func example(name: String = "", foo: () -> () ) {
  print("-----------------"+name+"-----------------")
  foo()
}

let disposeBag = DisposeBag()

let rxPokemonRepository: RxPokemonRepository = RxPokemonRepositoryImpl()
let coroutinePokemonRepository: CoroutinePokemonRepository = CoroutinePokemonRepositoryImpl()

// MARK: api1 request 이후 response data를 이용해 api2 request
//example(name: "rx - api1 request 이후 response data를 이용해 api2 request") {
//  let startTrigger = PublishRelay<Void>()
//
//  let allPokemonNumbers = startTrigger
//    .flatMapLatest{ _ -> Observable<AllPokemons> in
//      return rxPokemonRepository.fetchAllPokemons(limit: 10, offset: 0)
//    }
//    .flatMapLatest{ Observable.just($0.results.compactMap { $0.number } ) }
//
//  let pokemonInfos = allPokemonNumbers
//    .flatMapLatest{ numbers -> Observable<[PokemonInfo]> in
//      return Observable.combineLatest(numbers.map { rxPokemonRepository.fetchPokemonInfo(pokemonNumber: $0) })
//    }
//
//  pokemonInfos
//    .catch{ error in
//      print("error: ", error)
//      return .empty()
//    }
//    .subscribe(onNext: {
////      print($0)
//      print($0.count)
//    })
//    .disposed(by: disposeBag)
//
//  startTrigger.accept(())
//}

example(name: "async/await - api1 request 이후 response data를 이용해 api2 request") {
  Task {
    do {
      let pokemons = try await coroutinePokemonRepository.fetchAllPokemons(limit: 10, offset: 0)
      let pokemonNumbers = pokemons.results.compactMap { $0.number }
      var pokemonInfos: [PokemonInfo] = []
      for item in pokemonNumbers {
        let pokemonInfo = try await coroutinePokemonRepository.fetchPokemonInfo(pokemonNumber: item)
        pokemonInfos.append(pokemonInfo)
      }
      
//      print(pokemonInfos)
      print(pokemonInfos.count)
      
    }catch(let error){
      print("error: ", error)
    }
  }
}

// MARK:
