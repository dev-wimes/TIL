# Complex Asyncronous Skills

code: [Arena-Playground](./Arena-Playground)

## api1 request 이후 response data를 이용해 api2 request

### RxSwift

```swift
	let allPokemonNumbers = startTrigger
    .flatMapLatest{ _ -> Observable<AllPokemons> in
      return rxPokemonRepository.fetchAllPokemons(limit: 10, offset: 0)
    }
    .flatMapLatest{ Observable.just($0.results.compactMap { $0.number } ) }
  
  let pokemonInfos = allPokemonNumbers
    .flatMapLatest{ numbers -> Observable<[PokemonInfo]> in
      return Observable.combineLatest(numbers.map { rxPokemonRepository.fetchPokemonInfo(pokemonNumber: $0) })
    }
  
  pokemonInfos
    .catch{ error in
      print("error: ", error)
      return .empty()
    }
    .subscribe(onNext: {
//      print($0)
      print($0.count)
    })
    .disposed(by: disposeBag)
```

* allPokemonNumbers: fetchAllPokemons 를 이용해 AllPokemons를 받아오고 거기서 number만 추려서 스트림에 저장
* pokemonInfos: allPokemonNumbers의 스트림 값을 이용해 map을 돌려 fetchPokemonInfo로 각 번호마다 스트림(Observable)을 가져오고 combineLatest로 묶어서 방출
* subscribe: [PokemonInfo] 핸들링

### async/await

```swift
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
```

* pokemons: fetchAllPokemons 를 이용해 AllPokemons를 받아오고 거기서 number만 추려서 저장
* pokemonNumbers: 추려진 값에서 pokemonNumbers만 추출
* pokemonNumbers로 for loop 돌려서 pokemonInfo에 fetchPokemonInfo 호출해서 저장
* 마지막으로 pokemonInfos 핸들링

