# Complex Asyncronous Skills

code: [Arena-Playground](./Arena-Playground)



## api1이 성공한 이후  api2가 흐를 수 있도록 한다. api1은 a로, api2는 b가 목적지이다.

### RxSwift/Combine

**RxSwift**

```swift
	let startTrigger = PublishRelay<Void>()
  
  let pokemonsTrigger = PublishRelay<AllPokemons>()
  let beersTrigger = PublishRelay<[Beer]>()
  
  // api1
  let allPokemons = rxPokemonRepository.fetchAllPokemons(limit: 1, offset: 0)
    .catch{ error in
      print("error: ", error)
      return .empty()
    }
    .do(onNext: {
      pokemonsTrigger.accept($0)
    })
  
  // api2
  let beers = rxPunkRepository.fetchBeers(page: 1, perPage: 1)
      .catch{ error in
        print("error: ", error)
        return .empty()
      }
      .do(onNext: {
        beersTrigger.accept($0)
      })
  
  startTrigger
    .flatMapLatest { _ -> Observable<AllPokemons> in
      return allPokemons
    }
    .flatMapLatest { _ -> Observable<[Beer]> in
      return beers
    }
    .subscribe(onNext: { _ in
      
    })
    .disposed(by: disposeBag)
  
  pokemonsTrigger
    .subscribe(onNext: {
      print("pokemons: ", $0)
    })
    .disposed(by: disposeBag)
  
  beersTrigger
    .subscribe(onNext: {
//      print("beers: ", $0)
      print("beers count: ", $0.count)
    })
    .disposed(by: disposeBag)
  
  startTrigger.accept(())
```

**Combine**

```swift
	let startTrigger = PassthroughSubject<Void, Never>()
  
  let pokemonsTrigger = PassthroughSubject<AllPokemons, NetworkError>()
  let beersTrigger = PassthroughSubject<[Beer], NetworkError>()
  
  
  let fetchPokemons = combinePokemonRepository.fetchAllPokemons(limit: 1, offset: 0)
    .catch { failure -> AnyPublisher<AllPokemons, NetworkError> in
      print("error: ", failure)
      return .empty()
    }
    .handleEvents(receiveOutput: {
      pokemonsTrigger.send($0)
    })
    .eraseToAnyPublisher()
    
  let fetchBeers = combinePunkRepository.fetchBeers(page: 1, perPage: 1)
    .catch { failure -> AnyPublisher<[Beer], NetworkError> in
      print("error: ", failure)
      return .empty()
    }
    .handleEvents(receiveOutput: {
      beersTrigger.send($0)
    })
    .eraseToAnyPublisher()
  
  startTrigger
    .map { _ -> AnyPublisher<AllPokemons, NetworkError> in
      return fetchPokemons
    }
    .switchToLatest()
    .map { _ -> AnyPublisher<[Beer], NetworkError> in
      return fetchBeers
    }
    .switchToLatest()
    .sink { completion in
      if case let .failure(error) = completion {
        print("error: ", error)
      }
    } receiveValue: { _ in }
    .store(in: &cancelBag)

  pokemonsTrigger
    .sink { completion in
      if case let .failure(error) = completion {
        print("pokemonsTrigger error: ", error)
      }
    } receiveValue: { pokemons in
      print(pokemons)
//      print(pokemons.results.count)
    }
    .store(in: &cancelBag)
  
  beersTrigger
    .sink { completion in
      if case let .failure(error) = completion {
        print("beersTrigger error: ", error)
      }
    } receiveValue: { beers in
//      print(beers)
      print(beers.count)
    }
    .store(in: &cancelBag)

  startTrigger.send(())
```

* fetchPokemons: fetchAllPokemons 를 이용해 AllPokemons를 받아온다.
  * 실패 시 error 문구 출력 후 empty 리턴
  * 성공 시 pokemonsTrigger에 값을 방출한다.
* fetchBeers: fetchBeers를 이용해 [Beer]를 받아온다.
  * 실패 시 error 문구 출력 후 empty 리턴
  * 성공 시 beersTrigger에 값을 방출한다.
* 위의 fetchPokemons, fetchBeers를 두 스트림을 이용해 flatMapLatest로 각각 스트림을 호출 한다. 
  이 때 fetchPokemons를 먼저 호출 한다.( empty덕에 실패 시 해당 스트림이 끝이 난다. )
* 각 목적지 스트림(pokemonsTrigger, beersTrigger)에서 방출된 값을 받아서 출력한다.

### async/await

```swift
Task {
    var pokemons: AllPokemons? = nil
    do {
      pokemons = try await coroutinePokemonRepository.fetchAllPokemons(limit: 1, offset: 0)
    } catch(let error) {
      print("pokemons error: ", error)
    }
    
    var beers: [Beer] = []
    do {
      guard let _ = pokemons else { return }

      beers = try await coroutinePunkRepository.fetchBeers(page: 1, perPage: 1)
    } catch(let error) {
      print("beers error: ", error)
    }
    
    if let pokemons = pokemons {
      print("pokemons: ", pokemons)
    }
//    print("beers: ", beers)
    print("beers: ", beers.count)
}
```

* pokemons: fetchAllPokemons 를 이용해 AllPokemons를 받아온다. 실패 시 error 문구 출력
* beers: pokemons를 nil체크해서 이전 스트림이 성공했는지 체크 후 fetchBeers를 통해 beers를 받아온다.
* 마지막으로 pokemons와 beers를 출력한다.



## api1 request 이후 response data를 이용해 api2 request

### RxSwift/Combine

**RxSwift**

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

**Combine**

```swift
	let startTrigger = PassthroughSubject<Void, Never>()

  let allPokemonNumber = startTrigger
    .map { _ -> AnyPublisher<AllPokemons, NetworkError> in
      return combinePokemonRepository.fetchAllPokemons(limit: 10, offset: 0)
    }
    .switchToLatest()
    .map {
      Just($0.results.compactMap { $0.number })
    }

  let pokemonInfos = allPokemonNumber
    .map(\.output)
    .map { numbers -> AnyPublisher<[PokemonInfo], NetworkError> in
      return numbers.map { combinePokemonRepository.fetchPokemonInfo(pokemonNumber: $0).eraseToAnyPublisher() }
      .combineLatest()
    }
    .eraseToAnyPublisher()

  pokemonInfos
    .flatMap { $0 }
    .sink { result in
      switch result {
      case .failure(let error):
        print(error)
      case .finished:
        print("finished")
      }
    } receiveValue: { pokemonInfos in
      print(pokemonInfos.count)
//      print(pokemonInfos)
    }
    .store(in: &cancelBag)
  
  startTrigger.send(())
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

