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
let combinePokemonRepository: CombinePokemonRepository = CombinePokemonRepositoryImpl()
let coroutinePokemonRepository: CoroutinePokemonRepository = CoroutinePokemonRepositoryImpl()

// MARK: api1이 성공해야지만 api2의 스트림이 흐를 수 있도록
// MARK: 또한 각 response data의 목적지는 다름 api1 -> a, api2 -> b 로 방출

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
//  startTrigger.accept(())
//}

example(name: "combine - api1 request 이후 response data를 이용해 api2 request") {
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
  // @@todo catch는 각 api에 다는 것이 좋아보임 그래야 각각 핸들링 가능
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
}

example(name: "async/await - api1 request 이후 response data를 이용해 api2 request") {
  Task {
    var pokemons: AllPokemons? = nil
    do {
      pokemons = try await coroutinePokemonRepository.fetchAllPokemons(limit: 10, offset: 0)
    } catch(let error) {
      print("pokemons error: ", error)
    }
    
    var pokemonNumbers: [Int] = []
    var pokemonInfos: [PokemonInfo] = []
    do {
      pokemonNumbers = pokemons?.results.compactMap { $0.number } ?? []
      for item in pokemonNumbers {
        let pokemonInfo = try await coroutinePokemonRepository.fetchPokemonInfo(pokemonNumber: item)
        pokemonInfos.append(pokemonInfo)
      }
    } catch(let error) {
      print("pokemonInfos error: ", error)
    }
//      print(pokemonInfos)
    print(pokemonInfos.count)
  }
}

// MARK: api 1, 2의 데이터를 묶어서 방출해야 할 때
// MARK: api 1이 실패하면 전체 방출x
// MARK: api 2는 실패하고 api 1은 성공했을 때는 api 1은 방출, 2는 방출할 필요 없음
// MARK: (1, 2) -> [1, 2] 1과 2의 response 데이터는 가공을 해서 같은 타입으로 만들자 그래야 배열에 넣을 수 있으니...(프로토콜로 묶으면 될 듯)

// MARK: 3개 이상의 스트림 combineLatest 연산

// MARK: 3개 이상의 스트림 combineLatest 연산 + withLatestFrom 연산
