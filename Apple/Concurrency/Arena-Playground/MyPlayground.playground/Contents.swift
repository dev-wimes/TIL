// Playground generated with ๐ Arena (https://github.com/finestructure/arena)
// โน๏ธ If running the playground fails with an error "no such module ..."
//    go to Product -> Build to re-trigger building the SPM package.
// โน๏ธ Please restart Xcode if autocomplete is not working.

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

//// MARK: api1์ด ์ฑ๊ณตํด์ผ์ง๋ง api2์ ์คํธ๋ฆผ์ด ํ๋ฅผ ์ ์๋๋ก
//// MARK: ๋ํ ๊ฐ response data์ ๋ชฉ์ ์ง๋ ๋ค๋ฆ api1 -> a, api2 -> b ๋ก ๋ฐฉ์ถ
//example(name: "rx - api1์ด ์ฑ๊ณตํด์ผ์ง๋ง api2์ ์คํธ๋ฆผ์ด ํ๋ฅผ ์ ์๋๋ก, ๋ํ ๊ฐ response data์ ๋ชฉ์ ์ง๋ ๋ค๋ฆ api1 -> a, api2 -> b ๋ก ๋ฐฉ์ถ") {
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
//example(name: "combine - api1์ด ์ฑ๊ณตํด์ผ์ง๋ง api2์ ์คํธ๋ฆผ์ด ํ๋ฅผ ์ ์๋๋ก, ๋ํ ๊ฐ response data์ ๋ชฉ์ ์ง๋ ๋ค๋ฆ api1 -> a, api2 -> b ๋ก ๋ฐฉ์ถ") {
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
//example(name: "async/await - api1์ด ์ฑ๊ณตํด์ผ์ง๋ง api2์ ์คํธ๋ฆผ์ด ํ๋ฅผ ์ ์๋๋ก, ๋ํ ๊ฐ response data์ ๋ชฉ์ ์ง๋ ๋ค๋ฆ api1 -> a, api2 -> b ๋ก ๋ฐฉ์ถ") {
//  Task {
//    // @@todo do - catch ๊ฐ ํ๋์์ ๋ฃ์ ์ ์์๊น? ์ฆ, catch์์ error๊ฐ ์ด๋์ ๋๋์ง๋ฅผ ์ด๋ป๊ฒ ๊ฐ ์ ์์๊น?
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
//// MARK: api1 request ์ดํ response data๋ฅผ ์ด์ฉํด api2 request
//example(name: "rx - api1 request ์ดํ response data๋ฅผ ์ด์ฉํด api2 request") {
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
//  // @@todo catch๋ ๊ฐ api์ ๋ค๋ ๊ฒ์ด ์ข์๋ณด์ ๊ทธ๋์ผ ๊ฐ๊ฐ ํธ๋ค๋ง ๊ฐ๋ฅ
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
//example(name: "combine - api1 request ์ดํ response data๋ฅผ ์ด์ฉํด api2 request") {
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
//  // @@todo catch๋ ๊ฐ api์ ๋ค๋ ๊ฒ์ด ์ข์๋ณด์ ๊ทธ๋์ผ ๊ฐ๊ฐ ํธ๋ค๋ง ๊ฐ๋ฅ
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
//example(name: "async/await - api1 request ์ดํ response data๋ฅผ ์ด์ฉํด api2 request") {
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

// MARK: 3. api 1์ด ์คํจํ๋ฉด ์ ์ฒด ๋ฐฉ์ถx
// MARK: 3. api2๋ ์คํจํ๊ณ  api1์ ์ฑ๊ณตํ์ ๋๋ api1์ ๋ฐฉ์ถ, api2๋ ๋ฐฉ์ถ ๋ชปํจ
//example(name: "rx - api1์ด ์คํจํ๋ฉด ์ ์ฒด ๋ฐฉ์ถ x, api2๋ ์คํจํ๊ณ  api1์ ์ฑ๊ณตํ์ ๋๋ api1์ ๋ฐฉ์ถ, api2๋ ๋ฐฉ์ถ ๋ชปํจ") {
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
//example(name: "combine - api1์ด ์คํจํ๋ฉด ์ ์ฒด ๋ฐฉ์ถ x, api2๋ ์คํจํ๊ณ  api1์ ์ฑ๊ณตํ์ ๋๋ api1์ ๋ฐฉ์ถ, api2๋ ๋ฐฉ์ถ ๋ชปํจ") {
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

example(name: "async/await - api1์ด ์คํจํ๋ฉด ์ ์ฒด ๋ฐฉ์ถ x, api2๋ ์คํจํ๊ณ  api1์ ์ฑ๊ณตํ์ ๋๋ api1์ ๋ฐฉ์ถ, api2๋ ๋ฐฉ์ถ ๋ชปํจ") {
  Task {
    // @@todo do - catch ๊ฐ ํ๋์์ ๋ฃ์ ์ ์์๊น? ์ฆ, catch์์ error๊ฐ ์ด๋์ ๋๋์ง๋ฅผ ์ด๋ป๊ฒ ๊ฐ ์ ์์๊น?
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
// MARK: scrollView ์ํฉ์์ ptr, reached bottom, load ๊ตฌํ

// MARK: -case 5.
// MARK: 3๊ฐ์ api๊ฐ ์๋๋ฐ api3๊ฐ๊ฐ ๋ชจ๋ ์ฑ๊ณตํด์ผ์ง๋ง ๋ฐฉ์ถ
// MARK: api1, api2, api3 ์ค api1์ ์ฑ๊ณต api2๋ ์คํจํ๊ณ  api3๋ ์์ง ๋๊ธฐ์ค์ผ ๋
// MARK: api3์ ์์ฒญx, ๋ค์ ์คํธ๋ฆผ์ ํ๋ ธ์ ๋
// MARK: api1์ input ๊ฐ์ด ๋ณ๊ฒฝ๋์ง ์์์ ๊ฒฝ์ฐ ์์ฒญํ์ง ์๊ณ ,(input ๊ฐ์ด ๋ณ๊ฒฝ๋์์ ๊ฒฝ์ฐ ๋ค์ ์์ฒญ)
// MARK: api2๋ ๋ฌด์กฐ๊ฑด ์ฌ์์ฒญ
// MARK: api3๋ ์ฌ์์ฒญ
// MARK: ์ฆ, api 3๊ฐ๋ฅผ ๋ฌถ์ด์ ๋ชจ๋ ์ฑ๊ณตํ ๊ฒฝ์ฐ์๋ง ๋ฐฉ์ถํ๋๋ฐ, ๋ค์ ์์ฒญ ์ input์ด ๋ณ๊ฒฝ๋์ง ์์์ ๊ฒฝ์ฐ ์คํจํ api๋ง ๋ค์ ํธ์ถํ๋ค.

