// Playground generated with 🏟 Arena (https://github.com/finestructure/arena)
// ℹ️ If running the playground fails with an error "no such module ..."
//    go to Product -> Build to re-trigger building the SPM package.
// ℹ️ Please restart Xcode if autocomplete is not working.

import RxSwift
import Darwin
import Foundation

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
  let charlotte = Student(score: BehaviorSubject(value: 90))
  
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
// 기존 옵저버블이 동작하고 있는 도중에 새로운 옵저버블이 전달되면 기존것은 끊기게 되는 것을 제외하고는 flatMap과 동작이 똑같음.
example(name: "flatMapLatest") {
  struct Student{
    var score: BehaviorSubject<Int>
  }
  
  // Student 타입의 변수 2개를 생성 ryan은 80, charlotte는 90으로 초기화 되어있다.
  let ryan = Student(score: BehaviorSubject(value: 80))
  let charlotte = Student(score: BehaviorSubject(value: 90))
  
  let student = PublishSubject<Student>()
  
  student
    .flatMapLatest({ (element: Student) -> Observable<Int> in
      element.score
    })
    .subscribe(onNext:{ (result: Int) in
      print(result)
    })
    .disposed(by: disposeBag)
  
  student.onNext(ryan)
  ryan.score.onNext(85)
  // 여기서부터는 ryan 시퀀스는 무시된다.
  student.onNext(charlotte)
  
  // 얘는 누락됨
  ryan.score.onNext(95)
  
  charlotte.score.onNext(100)
  /*
   80
   85
   90
   100
   */
}

// 네트워크 통신에서 많이 사용됨.
// 예를 들어 검색어 자동완성 같이 G만 쳤을 때 나오는 것과 GO를 쳤을 때 나오는 것이 다르듯
// 사용자가 마지막에 친 문자열에 대해서 자동완성을 시켜주는 것과 같은 기능을 구현할 수 있다.
// G에서 이어지는 동작이 끊기고 마지막에 방출된 GO로 이어지는 동작만 살아있는 것
// http://minsone.github.io/programming/reactive-swift-observable-chaining-async-task
// https://ntomios.tistory.com/11
example(name: "network with flatMapLatest") {
  
}

// MARK: - filter
// 조건에 해당하는 값만 방출
example(name: "filter") {
  Observable.of(1, 2, 3, 4, 5)
    .filter({ (element: Int) -> Bool in
      element < 3
    })
    .subscribe(onNext:{ (result: Int) in
      print(result)
    })
    .disposed(by: disposeBag)
  /*
   1
   2
   */
}

// MARK: - take
// 몇개의 엘리먼트를 가져올지 정해준다.
example(name: "take") {
  Observable.of(1, 2, 3, 4)
    .take(2)
    .subscribe(onNext:{
      print($0)
    })
    .disposed(by: disposeBag)
  /*
   1
   2
   */
}

// MARK: - take(while:)
// 조건식이 false가 되기 전까지는 방출하고 false가 되면 뒤로는 무시
example(name: "take(while:)") {
  Observable.of(1, 2, 3, 4, 5)
    .take(while: {
      $0 != 5
    })
    .subscribe(onNext:{
      print($0)
    })
    .disposed(by: disposeBag)
  /*
   1
   2
   3
   4
   */
}

// MARK: - take(until:)
// 어떤 다른 옵저버블의 실행이 있기전까지 가져오고 그 뒤론 종료
example(name: "take(until:)") {
  let subject = PublishSubject<Int>()
  let subject2 = PublishSubject<Int>()
  
  subject
    .take(until: subject2)
    .subscribe(onNext:{
      print($0)
    })
    .disposed(by: disposeBag)
  
  subject.onNext(1)
  subject.onNext(2)
  subject2.onNext(10)
  subject.onNext(3)
  subject2.onNext(20)
  subject.onNext(4)
  /*
   1
   2
   */
}

// MARK: - startWith
// Observable 시퀀스 앞에 값을 추가해준다.
example(name: "startWith") {
  Observable.of(1, 2, 3, 4)
    .startWith(0)
    .subscribe(onNext:{
      print($0)
    })
    .disposed(by: disposeBag)
  /*
   0
   1
   2
   3
   4
   */
}

// MARK: - merge
// https://rhammer.tistory.com/309?category=649741
// Observable 시퀀스를 순서없이 합쳐준다.
// 1번 2번 Observable이 있다고 했을 때 1번 시퀀스 방출 하고 2번 시퀀스 방출이 아니라 시퀀스에 대해 순서가 없이 그냥 흐름대로 합쳐준다.
example(name: "merge") {
  let left = Observable.of("0", "1")
  let right = Observable.of("zero", "one")
  
//  let source = Observable.of(left, right)
  
  // 이렇게 해도 됨
  //  source.merge()
  Observable.merge(left, right)
    .subscribe(onNext:{
      print($0)
    })
    .disposed(by: disposeBag)
  /*
   0
   zero
   1
   one
   */
}

// MARK: - withLatestFrom
// https://rhammer.tistory.com/349?category=649741
// 각기 두개의 Observable을 합성한다. 다만 첫번째 Observable의 이벤트가 발생해야 지만 2개를 묶어서 최종 시퀀스로 전달한다.
// 첫번째 이벤트가 없다면 최종시퀀스로 전달x

example(name: "withLatestFrom") {
  let inputNumber = PublishSubject<Int>()
  let inputString = PublishSubject<String>()
  
  inputNumber
    .withLatestFrom(inputString){ (lhs: Int, rhs: String) -> String in
      "\(lhs):\(rhs)"
    }
    .subscribe(onNext:{
      print($0)
    })
    .disposed(by: disposeBag)
  
  // 방출x
  inputNumber.onNext(1)
  inputString.onNext("one")
  
  // 2:one
  inputNumber.onNext(2)
  inputString.onNext("two")
  inputString.onNext("three")
  inputString.onNext("four")
  
  // 3:four
  inputNumber.onNext(3)
  
  // 4:four
  inputNumber.onNext(4)
  
  // 5:four
  inputNumber.onNext(5)
  /*
   2:one
   3:four
   4:four
   5:four
   */
}

example(name: "button and textFiled") {
  let button = PublishSubject<Void>()
  let textField = PublishSubject<String>()
  
  button
    .withLatestFrom(textField)
    .subscribe(onNext:{
      print($0)
    })
    .disposed(by: disposeBag)
  
  // textField에 입력중
  textField.onNext("Par")
  textField.onNext("Pari")
  textField.onNext("Paris")
  
  // 다 입력하고 버튼을 두번 탭
  button.onNext(())
  button.onNext(())
  
  /*
   Paris
   Paris
   */
}

// MARK: - combineLatest
// https://rhammer.tistory.com/311?category=649741
// 2개의 Observable에 각각의 이벤트가 발생했을 때 최신이벤트끼리 묶어서 최종 시퀀스에 전달한다.

example(name: "combineLatest") {
  let left = PublishSubject<String>()
  let right = PublishSubject<String>()
  
  Observable
    .combineLatest(left, right) { lastLeft, lastRight in
      "\(lastLeft) \(lastRight)"
    }
    .subscribe(onNext:{
      print($0)
    })
    .disposed(by: disposeBag)
  
  print("> Sending a value to left")
  left.onNext("Hello, ")
  
  print("> Sending a value to right")
  right.onNext("world")
  
  print("> Sending another value to right")
  right.onNext("RxSwift")
  
  print("> Sending another value to left")
  left.onNext("Have a good day,")
  /*
   > Sending a value to left
   > Sending a value to right
   Hello,  world
   > Sending another value to right
   Hello,  RxSwift
   > Sending another value to left
   Have a good day, RxSwift
   */
}

example(name: "combine user choice and value") {
  let choice: Observable<DateFormatter.Style> = Observable.of(.short, .long)
  let dates = Observable.of(Date())
  
  Observable.combineLatest(choice, dates){ (format: DateFormatter.Style, when: Date) -> String in
    let formatter = DateFormatter()
    formatter.dateStyle = format
    
    return formatter.string(from: when)
  }
  .subscribe(onNext:{
    print($0)
  })
  .disposed(by: disposeBag)
  
  /*
   2022/03/07
   March 7, 2022
   */
  
  // 궁금한거 지금은 시간상에서 .short, .long 시퀀스 사이에 Date() 엘리먼트가 방출되서 .short, Date() / .long, Date() 쌍으로 묶였지만,
  // .short, .long 시퀀스 이후에 Date() 엘리먼트가 방출되면..?
  // -> 당연히 .long, Date() 쌍으로만 묶일 것임. 그래서 combineLatest 이런 경우가 안생긴다는 보장하에 써야 함
}

// MARK: - throttle
// https://eunjin3786.tistory.com/80
// https://opendoorlife.tistory.com/19
// 지정된 시간동안 Observable이 내보낸 첫번째 엘리먼트와 마지막 엘리먼트(latest 에 따라 다름)를 내보내는 Observable을 반환한다.
// 이 연산자는 DueTime보다 짧은 시간에 두개의 요소가 내보내지지 않도록 한다.
// (참고: 방출하면 throttle 타이머 흘러감)
// 지정된 시간안에 수많은 이벤트가 발생해도 2개 이상 요소가 방출되지 않는다는 얘기
//example(name: "throttle") {
//  Observable<Int>
//    .interval(.seconds(2), scheduler: MainScheduler.instance)
//    .take(6)
//
//  // latest = true
////    .throttle(.seconds(5), scheduler: MainScheduler.instance)
////    .subscribe(onNext:{
////      print($0)
////    })
////    .disposed(by: disposeBag)
//  /*
//   0
//   2
//   5
//   */
//
//  // latest = false
//    .throttle(.seconds(5), latest: false, scheduler: MainScheduler.instance)
//    .subscribe(onNext:{
//      print($0)
//    })
//    .disposed(by: disposeBag)
//  /*
//   0
//   3
//   */
//}

// MARK: - debounce
// 지정된 시간간격 내에 마지막 하나의 source 이벤트를 최종 시퀀스에 방출한다. source 이벤트가 방출될 때마다 타이머는 초기화된다.
example(name: "debounce") {
  Observable<Int>
    .interval(.seconds(2), scheduler: MainScheduler.instance)
    .take(3)
    .debounce(.seconds(1), scheduler: MainScheduler.instance)
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
  /*
   0
   1
   2
   */
}

// MARK: - share
// https://jusung.github.io/shareReplay/


