// Playground generated with 🏟 Arena (https://github.com/finestructure/arena)
// ℹ️ If running the playground fails with an error "no such module ..."
//    go to Product -> Build to re-trigger building the SPM package.
// ℹ️ Please restart Xcode if autocomplete is not working.

import RxSwift

let disposeBag = DisposeBag()

func example(name: String, foo: () -> ()){
  print("-----------------"+name+"-----------------")
  foo()
}

// MARK: - map
// 방출되는 값에 어떤 변형을 주어 방출하는 오퍼레이터
example(name: "map") {
  Observable.of(1, 2, 3)
    .map({ (result: Int) -> Int in
      result * 10
    })
    .subscribe(onNext:{
      print($0)
    })
    .disposed(by: disposeBag)
  /*
   10
   20
   30
   */

  Observable.of(1, 2, 3)
    .map({ (result: Int) -> String in
      "\(result)"
    })
    .subscribe(onNext:{
      print("String: " + $0)
    })
  // onNext가 없으면 Event<Element> 를 받는데 이는 next, error 이런 이벤트를 핸들링 하기 위함임.
//    .subscribe({
//      print("String: " + $0)
//      switch $0{
//      case let .next(value):
//        print(value)
//      case let .error(error):
//        print(error)
//      default:
//        print("finished")
//      }
//    })
    .disposed(by: disposeBag)
  /*
   String: 1
   String: 2
   String: 3
   */
}

// MARK: - enumerated
// index와 value를 파라미터로 받아서 값으로 리턴
example(name: "enumerated") {
  Observable.of(1, 2, 3, 4, 5)
    .enumerated()
    .map({ (index: Int, value: Int) -> String in
      index > 3 ? "\(value)" : "x"
    })
    .subscribe(onNext:{
      print($0)
    })
    .disposed(by: disposeBag)
  /*
   x
   x
   x
   x
   5
   */
}


// MARK: - flatMap
// 이벤트를 다른 Observable로 변경
// Observable 시퀀스의 element당 한개의 새로운 Observable 시퀀스를 생성한다. 이렇게 생성된 여러개의 새로운 시퀀스를 하나의 시퀀스로 만들어 준다.
example(name: "flatMap") {
  Observable.of(1, 2, 3)
    .flatMap({ (result: Int) -> Observable<String> in
      Observable.just("\(result)")
    })
    .subscribe(onNext:{ (result: String) in
      print("String: " + result)
    })
    .disposed(by: disposeBag)
  /*
   String: 1
   String: 2
   String: 3
   */

  // 비동기 처리할 때 많이 쓰임
  // https://jcsoohwancho.github.io/2019-09-09-Rxswift%EC%97%B0%EC%82%B0%EC%9E%90-flatmap/
  // 1초마다 second를 방출
//  let timer1 = Observable<Int>
//    .interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//    .map({"o1: \($0)"})
//  // 2초마다 second를 방출
//  let timer2 = Observable<Int>
//    .interval(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
//    .map({"o2: \($0)"})
//
//  Observable.of(timer1, timer2)
//    .flatMap({ (emit: Observable<String>) -> Observable<String> in
//      emit
//    })
//    .subscribe({ (result: Event<String>) -> Void in
//      print(result)
//      switch result{
//      case let .next(value):
//        print(value)
//      default:
//        print("finished")
//      }
//    })
//    .disposed(by: disposeBag)
  /*
   next(o1: 0)
   o1: 0
   next(o1: 1)
   o1: 1
   next(o2: 0)
   o2: 0
   next(o1: 2)
   o1: 2
   next(o1: 3)
   o1: 3
   next(o2: 1)
   o2: 1
   next(o1: 4)
   o1: 4
   next(o1: 5)
   o1: 5
   next(o2: 2)
   o2: 2
   */
}

// MARK: - map vs flatMap
example(name: "map vs flatMap") {
//  let timer1 = Observable<Int>
//    .interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//    .map({"o1: \($0)"})
//  let timer2 = Observable<Int>
//    .interval(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
//    .map({"o2: \($0)"})
//
//  Observable.of(timer1, timer2)
//    .flatMap({ (emit: Observable<String>) -> Observable<String> in
//      emit
//    })
//    .subscribe(onNext: { (result: String) -> Void in
//      print(result)
//    })
//    .disposed(by: disposeBag)
  /*
   o1: 0
   o1: 1
   o2: 0
   o1: 2
   o1: 3
   o2: 1
   o1: 4
   o1: 5
   o2: 2
   */
  
  // map이랑 비교
//  Observable.of(timer1, timer2)
//    .map({ (emit: Observable<String>) -> Observable<String> in
//      emit
//    })
//    .subscribe(onNext: { (result: Observable<String>) in
//      print(result)
//    })
//    .disposed(by: disposeBag)
  /*
   RxSwift.(unknown context at $12071da78).Map<Swift.Int, Swift.String>
   RxSwift.(unknown context at $12071da78).Map<Swift.Int, Swift.String>
   next(o1: 0)
   o1: 0
   next(o1: 1)
   o1: 1
   next(o2: 0)
   o2: 0
   next(o1: 2)
   o1: 2
   next(o1: 3)
   o1: 3
   next(o2: 1)
   o2: 1
   next(o1: 4)
   o1: 4
   next(o1: 5)
   o1: 5
   next(o2: 2)
   o2: 2
   */
  
  // map은 Observable 값 그대로 받는 반면에: Observable<Element> --> subscribe({ Observable<Element> ... })
  // flatMap은 언래핑해서 받고있음: Observable<Element> --> subscribe({ Element ... })
}

example(name: "question. flatMap") {
  // map이나 observable이나 subscribe에서 받을 때 프리미티브한 값을 받는데 뭐지 위에 map vs flatMap에서는 두개 받는게 달랐잖아
  Observable.of(1, 2, 3)
    .map({ (emit: Int) -> Observable<Int> in
      Observable.just(emit)
    })
    .subscribe(onNext:{ (result: Observable<Int>) in
      print(result)
    })
    .disposed(by: disposeBag)
  
  Observable.of(1, 2, 3)
    .flatMap({ (emit: Int) -> Observable<Int> in
      Observable.just(emit)
    })
    .subscribe(onNext:{ (result: Int) in
      print(result)
    })
    .disposed(by: disposeBag)
  
  // map, flatMap에서의 return 값의 형태만 다르고 최종 subscribe에서 받는 값은 타입이 같음.
  // 이 경우 둘의 차이점은 무엇일까?
}

example(name: "answer. flatMap") {
  struct Student{
    var score: BehaviorSubject<Int>
  }
  
  // Student 타입의 변수 2개를 생성 ryan은 80, charlotte는 90으로 초기화 되어있다.
  let ryan = Student(score: BehaviorSubject(value: 80))
  var charlotte = Student(score: BehaviorSubject(value: 90))
  
  let student = PublishSubject<Student>()
  
  // student의 시퀀스를 변환한다.
  student
  // Student 에서 Observable<Int>으로 변환
    .flatMap({ (element: Student) -> Observable<Int> in
      element.score
    })
    .subscribe(onNext:{ (result: Int) in
      print(result)
    })
    .disposed(by: disposeBag)
  
//  student
//    .map({ (element: Student) -> Observable<Int> in
//      element.score
//    })
//    .subscribe(onNext:{ (result: Observable<Int>) in
//      result.subscribe(onNext:{
//        print($0)
//      })
//        .disposed(by: disposeBag)
//    })
//    .disposed(by: disposeBag)
  
  student.onNext(ryan)
  ryan.score.onNext(85)
  student.onNext(charlotte)
  charlotte.score.onNext(95)
  charlotte.score.onNext(100)
}

// MARK: - flatMapLatest


// MARK: - filter
//

// MARK: - take
// MARK: - merge

// MARK: - withLatestFrom
// MARK: - share
// MARK: - combineLatest
// MARK: - startWith
// MARK: - debounce
// MARK: - throttle
