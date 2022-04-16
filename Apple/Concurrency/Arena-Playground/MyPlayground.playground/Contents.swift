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

// MARK: api1 request 이후 response data를 이용해 api2 request
example(name: "") {
  let startTrigger = PublishRelay<Void>()

  startTrigger
    .flatMap{ _ -> Observable<[PokemonInfo]> in
      
    }

  startTrigger.accept(())

}

// MARK:
