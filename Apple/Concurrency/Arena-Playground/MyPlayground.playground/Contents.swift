// Playground generated with 🏟 Arena (https://github.com/finestructure/arena)
// ℹ️ If running the playground fails with an error "no such module ..."
//    go to Product -> Build to re-trigger building the SPM package.
// ℹ️ Please restart Xcode if autocomplete is not working.

import RxSwift
import RxRelay
import _Concurrency
import Combine
import CombineExt

func example(name: String = "", foo: () -> () ) {
  print("-----------------"+name+"-----------------")
  foo()
}

let disposeBag = DisposeBag()
var cancelBag = Set<AnyCancellable>()

let rxPokemonRepository: RxPokemonRepository = RxPokemonRepositoryImpl()
let rxPunkRepository: RxPunkRepository = RxPunkRepositoryImpl()
let combinePokemonRepository: CombinePokemonRepository = CombinePokemonRepositoryImpl()
let combinePunkRepository: CombinePunkRepository = CombinePunkRepositoryImpl()
let coroutinePokemonRepository: CoroutinePokemonRepository = CoroutinePokemonRepositoryImpl()
let coroutinePunkRepository: CoroutinePunkRepository = CoroutinePunkRepositoryImpl()

//// MARK: api1이 성공해야지만 api2의 스트림이 흐를 수 있도록
//// MARK: 또한 각 response data의 목적지는 다름 api1 -> a, api2 -> b 로 방출
//example(name: "rx - api1이 성공해야지만 api2의 스트림이 흐를 수 있도록, 또한 각 response data의 목적지는 다름 api1 -> a, api2 -> b 로 방출") {
//  let startTrigger = PublishRelay<Void>()
//
//  let pokemonsTrigger = PublishRelay<AllPokemons>()
//  let beersTrigger = PublishRelay<[Beer]>()
//
//  // api1
//  let allPokemons = rxPokemonRepository.fetchAllPokemons(limit: 1, offset: 0)
//    .catch{ error in
//      print("error: ", error)
//      return .empty()
//    }
//    .do(onNext: {
//      pokemonsTrigger.accept($0)
//    })
//
//  // api2
//  let beers = rxPunkRepository.fetchBeers(page: 1, perPage: 1)
//      .catch{ error in
//        print("error: ", error)
//        return .empty()
//      }
//      .do(onNext: {
//        beersTrigger.accept($0)
//      })
//
//  startTrigger
//    .flatMapLatest { _ -> Observable<AllPokemons> in
//      return allPokemons
//    }
//    .flatMapLatest { _ -> Observable<[Beer]> in
//      return beers
//    }
//    .subscribe(onNext: { _ in
//
//    })
//    .disposed(by: disposeBag)
//
//  pokemonsTrigger
//    .subscribe(onNext: {
//      print("pokemons: ", $0)
//    })
//    .disposed(by: disposeBag)
//
//  beersTrigger
//    .subscribe(onNext: {
////      print("beers: ", $0)
//      print("beers count: ", $0.count)
//    })
//    .disposed(by: disposeBag)
//
//  startTrigger.accept(())
//}
//
//example(name: "combine - api1이 성공해야지만 api2의 스트림이 흐를 수 있도록, 또한 각 response data의 목적지는 다름 api1 -> a, api2 -> b 로 방출") {
//  let startTrigger = PassthroughSubject<Void, Never>()
//
//  let pokemonsTrigger = PassthroughSubject<AllPokemons, NetworkError>()
//  let beersTrigger = PassthroughSubject<[Beer], NetworkError>()
//
//
//  let fetchPokemons = combinePokemonRepository.fetchAllPokemons(limit: 1, offset: 0)
//    .catch { failure -> AnyPublisher<AllPokemons, NetworkError> in
//      print("error: ", failure)
//      return .empty()
//    }
//    .handleEvents(receiveOutput: {
//      pokemonsTrigger.send($0)
//    })
//    .eraseToAnyPublisher()
//
//  let fetchBeers = combinePunkRepository.fetchBeers(page: 1, perPage: 1)
//    .catch { failure -> AnyPublisher<[Beer], NetworkError> in
//      print("error: ", failure)
//      return .empty()
//    }
//    .handleEvents(receiveOutput: {
//      beersTrigger.send($0)
//    })
//    .eraseToAnyPublisher()
//
//  startTrigger
//    .map { _ -> AnyPublisher<AllPokemons, NetworkError> in
//      return fetchPokemons
//    }
//    .switchToLatest()
//    .map { _ -> AnyPublisher<[Beer], NetworkError> in
//      return fetchBeers
//    }
//    .switchToLatest()
//    .sink { completion in
//      if case let .failure(error) = completion {
//        print("error: ", error)
//      }
//    } receiveValue: { _ in }
//    .store(in: &cancelBag)
//
//  pokemonsTrigger
//    .sink { completion in
//      if case let .failure(error) = completion {
//        print("pokemonsTrigger error: ", error)
//      }
//    } receiveValue: { pokemons in
//      print(pokemons)
////      print(pokemons.results.count)
//    }
//    .store(in: &cancelBag)
//
//  beersTrigger
//    .sink { completion in
//      if case let .failure(error) = completion {
//        print("beersTrigger error: ", error)
//      }
//    } receiveValue: { beers in
////      print(beers)
//      print(beers.count)
//    }
//    .store(in: &cancelBag)
//
//  startTrigger.send(())
//}
//
//
//example(name: "async/await - api1이 성공해야지만 api2의 스트림이 흐를 수 있도록, 또한 각 response data의 목적지는 다름 api1 -> a, api2 -> b 로 방출") {
//  Task {
//    // @@todo do - catch 가 하나안에 넣을 수 없을까? 즉, catch에서 error가 어디서 나는지를 어떻게 갈 수 있을까?
//    var pokemons: AllPokemons? = nil
//    do {
//      pokemons = try await coroutinePokemonRepository.fetchAllPokemons(limit: 1, offset: 0)
//    } catch(let error) {
//      print("pokemons error: ", error)
//    }
//
//    var beers: [Beer] = []
//    do {
//      guard let _ = pokemons else { return }
//
//      beers = try await coroutinePunkRepository.fetchBeers(page: 1, perPage: 1)
//    } catch(let error) {
//      print("beers error: ", error)
//    }
//
//    if let pokemons = pokemons {
//      print("pokemons: ", pokemons)
//    }
////    print("beers: ", beers)
//    print("beers: ", beers.count)
//  }
//}
//
//// MARK: api1 request 이후 response data를 이용해 api2 request
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
//  // @@todo catch는 각 api에 다는 것이 좋아보임 그래야 각각 핸들링 가능
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
////  startTrigger.accept(())
//}
//
//example(name: "combine - api1 request 이후 response data를 이용해 api2 request") {
//  let startTrigger = PassthroughSubject<Void, Never>()
//
//  let allPokemonNumber = startTrigger
//    .map { _ -> AnyPublisher<AllPokemons, NetworkError> in
//      return combinePokemonRepository.fetchAllPokemons(limit: 10, offset: 0)
//    }
//    .switchToLatest()
//    .map {
//      Just($0.results.compactMap { $0.number })
//    }
//
//  let pokemonInfos = allPokemonNumber
//    .map(\.output)
//    .map { numbers -> AnyPublisher<[PokemonInfo], NetworkError> in
//      return numbers.map { combinePokemonRepository.fetchPokemonInfo(pokemonNumber: $0).eraseToAnyPublisher() }
//      .combineLatest()
//    }
//    .eraseToAnyPublisher()
//
//  pokemonInfos
//  // @@todo catch는 각 api에 다는 것이 좋아보임 그래야 각각 핸들링 가능
//    .flatMap { $0 }
//    .sink { result in
//      switch result {
//      case .failure(let error):
//        print(error)
//      case .finished:
//        print("finished")
//      }
//    } receiveValue: { pokemonInfos in
//      print(pokemonInfos.count)
//      //      print(pokemonInfos)
//    }
//    .store(in: &cancelBag)
//
////  startTrigger.send(())
//}
//
//example(name: "async/await - api1 request 이후 response data를 이용해 api2 request") {
//  Task {
//    var pokemons: AllPokemons? = nil
//    do {
//      pokemons = try await coroutinePokemonRepository.fetchAllPokemons(limit: 10, offset: 0)
//    } catch(let error) {
//      print("pokemons error: ", error)
//    }
//
//    var pokemonNumbers: [Int] = []
//    var pokemonInfos: [PokemonInfo] = []
//    do {
//      pokemonNumbers = pokemons?.results.compactMap { $0.number } ?? []
//      for item in pokemonNumbers {
//        let pokemonInfo = try await coroutinePokemonRepository.fetchPokemonInfo(pokemonNumber: item)
//        pokemonInfos.append(pokemonInfo)
//      }
//    } catch(let error) {
//      print("pokemonInfos error: ", error)
//    }
//    //      print(pokemonInfos)
//    print(pokemonInfos.count)
//  }
//}

// MARK: 3. api 1이 실패하면 전체 방출x
// MARK: 3. api2는 실패하고 api1은 성공했을 때는 api1은 방출, api2는 방출 못함
//example(name: "rx - api1이 실패하면 전체 방출 x, api2는 실패하고 api1은 성공했을 때는 api1은 방출, api2는 방출 못함") {
//  let startTrigger = PublishRelay<Void>()
//  let sharedStartTrigger = startTrigger.share()
//
//  let allPokemonsStream = sharedStartTrigger
//    .flatMapLatest { _ in
//      return rxPokemonRepository.fetchAllPokemons(limit: 1, offset: 0)
//    }
//    .catch { error in
//      print("rx-pokemon error: ", error)
//      return .empty()
//    }
//    .share()
//
//  let beersStream = allPokemonsStream
//    .flatMapLatest { _ in
//      return rxPunkRepository.fetchBeers(page: 1, perPage: 1)
//    }
////    .map { _ in throw NetworkError.unknown }
//    .catch { error -> Observable<[Beer]> in
//      print("rx-beers error: ", error)
//      return .empty()
//    }
//
//  allPokemonsStream
//    .subscribe(onNext: { allPokemons in
//      print("rx-allPokemons: ", allPokemons.count)
////      print("allPokemons: ", allPokemons)
//    })
//    .disposed(by: disposeBag)
//
//  beersStream
//    .subscribe(onNext: { beers in
//      print("rx-beers: ", beers.count)
////      print("beers: ", beers)
//    })
//    .disposed(by: disposeBag)
//
//  startTrigger.accept(())
//}
//
//example(name: "combine - api1이 실패하면 전체 방출 x, api2는 실패하고 api1은 성공했을 때는 api1은 방출, api2는 방출 못함") {
//  let startTrigger = PassthroughSubject<Void, Never>()
//  let sharedStartTrigger = startTrigger.share()
//
//  let allPokemonsStram = sharedStartTrigger
//    .map { _ -> AnyPublisher<AllPokemons, NetworkError> in
//      return combinePokemonRepository.fetchAllPokemons(limit: 1, offset: 0)
//    }
//    .switchToLatest()
//    .catch { error -> AnyPublisher<AllPokemons, NetworkError> in
//      print("combine-pokemon error: ", error)
//      return .empty()
//    }
//    .share()
//
//  let beersStream = allPokemonsStram
//    .map { _ in
//      return combinePunkRepository.fetchBeers(page: 1, perPage: 1)
//    }
//    .switchToLatest()
//    .assertFailure(.unknown)
//    .catch { error -> AnyPublisher<[Beer], NetworkError> in
//      print("combine-beers error: ", error)
//      return .empty()
//    }
//
//  allPokemonsStram
//    .sink(
//      receiveCompletion: { _ in },
//      receiveValue: { allPokemons in
//        print("combine-allPokemons.count: ", allPokemons.count)
//      }
//    )
//    .store(in: &cancelBag)
//
//  beersStream
//    .sink { _ in } receiveValue: { beers in
//      print("combine-beers.count: ", beers.count)
////      print("beers: ", beers)
//    }
//    .store(in: &cancelBag)
//
//  startTrigger.send(())
//}

example(name: "async/await - api1이 실패하면 전체 방출 x, api2는 실패하고 api1은 성공했을 때는 api1은 방출, api2는 방출 못함") {
  Task {
    // @@todo do - catch 가 하나안에 넣을 수 없을까? 즉, catch에서 error가 어디서 나는지를 어떻게 갈 수 있을까?
    var pokemons: AllPokemons? = nil
    var pokemonsSuccess: Bool = false
    do {
      pokemons = try await coroutinePokemonRepository.fetchAllPokemons(limit: 1, offset: 0)
      pokemonsSuccess = true
    } catch(let error) {
      print("pokemons error: ", error)
      pokemonsSuccess = false
    }
    
    var beers: [Beer]? = nil
    do {
      guard let _ = pokemons,
            pokemonsSuccess
      else { return }
//      throw NetworkError.unknown
      beers = try await coroutinePunkRepository.fetchBeers(page: 1, perPage: 1)
    } catch(let error) {
      print("beers error: ", error)
    }
    
    if let pokemons = pokemons {
      print("pokemons.count: ", pokemons.count)
    }
    
    // print("beers: ", beers)
    if let beers = beers {
      print("beers.count: ", beers.count)
    }
  }
}

// MARK: -case 4.
// MARK: scrollView 상황에서 ptr, reached bottom, load 구현

// MARK: -case 5.
// MARK: 3개의 api가 있는데 api3개가 모두 성공해야지만 방출
// MARK: api1, api2, api3 중 api1은 성공 api2는 실패하고 api3는 아직 대기중일 때
// MARK: api3은 요청x, 다시 스트림을 흘렸을 때
// MARK: api1은 input 값이 변경되지 않았을 경우 요청하지 않고,(input 값이 변경되었을 경우 다시 요청)
// MARK: api2는 무조건 재요청
// MARK: api3도 재요청
// MARK: 즉, api 3개를 묶어서 모두 성공한 경우에만 방출하는데, 다음 요청 시 input이 변경되지 않았을 경우 실패한 api만 다시 호출한다.

