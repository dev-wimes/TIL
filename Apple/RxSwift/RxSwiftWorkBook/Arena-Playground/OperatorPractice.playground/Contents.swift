// Playground generated with ๐ Arena (https://github.com/finestructure/arena)
// โน๏ธ If running the playground fails with an error "no such module ..."
//    go to Product -> Build to re-trigger building the SPM package.
// โน๏ธ Please restart Xcode if autocomplete is not working.

import RxSwift
import Darwin
import Foundation

let disposeBag = DisposeBag()

func example(name: String, foo: () -> ()){
  print("-----------------"+name+"-----------------")
  foo()
}

// MARK: - map
// ๋ฐฉ์ถ๋๋ ๊ฐ์ ์ด๋ค ๋ณํ์ ์ฃผ์ด ๋ฐฉ์ถํ๋ ์คํผ๋ ์ดํฐ
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
  // onNext๊ฐ ์์ผ๋ฉด Event<Element> ๋ฅผ ๋ฐ๋๋ฐ ์ด๋ next, error ์ด๋ฐ ์ด๋ฒคํธ๋ฅผ ํธ๋ค๋ง ํ๊ธฐ ์ํจ์.
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
// index์ value๋ฅผ ํ๋ผ๋ฏธํฐ๋ก ๋ฐ์์ ๊ฐ์ผ๋ก ๋ฆฌํด
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
// ์ด๋ฒคํธ๋ฅผ ๋ค๋ฅธ Observable๋ก ๋ณ๊ฒฝ
// Observable ์ํ์ค์ element๋น ํ๊ฐ์ ์๋ก์ด Observable ์ํ์ค๋ฅผ ์์ฑํ๋ค. ์ด๋ ๊ฒ ์์ฑ๋ ์ฌ๋ฌ๊ฐ์ ์๋ก์ด ์ํ์ค๋ฅผ ํ๋์ ์ํ์ค๋ก ๋ง๋ค์ด ์ค๋ค.
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

  // ๋น๋๊ธฐ ์ฒ๋ฆฌํ  ๋ ๋ง์ด ์ฐ์
  // https://jcsoohwancho.github.io/2019-09-09-Rxswift%EC%97%B0%EC%82%B0%EC%9E%90-flatmap/
  // 1์ด๋ง๋ค second๋ฅผ ๋ฐฉ์ถ
//  let timer1 = Observable<Int>
//    .interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//    .map({"o1: \($0)"})
//  // 2์ด๋ง๋ค second๋ฅผ ๋ฐฉ์ถ
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
  
  // map์ด๋ ๋น๊ต
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
  
  // map์ Observable ๊ฐ ๊ทธ๋๋ก ๋ฐ๋ ๋ฐ๋ฉด์: Observable<Element> --> subscribe({ Observable<Element> ... })
  // flatMap์ ์ธ๋ํํด์ ๋ฐ๊ณ ์์: Observable<Element> --> subscribe({ Element ... })
}

example(name: "question. flatMap") {
  // map์ด๋ observable์ด๋ subscribe์์ ๋ฐ์ ๋ ํ๋ฆฌ๋ฏธํฐ๋ธํ ๊ฐ์ ๋ฐ๋๋ฐ ๋ญ์ง ์์ map vs flatMap์์๋ ๋๊ฐ ๋ฐ๋๊ฒ ๋ฌ๋์์
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
  
  // map, flatMap์์์ return ๊ฐ์ ํํ๋ง ๋ค๋ฅด๊ณ  ์ต์ข subscribe์์ ๋ฐ๋ ๊ฐ์ ํ์์ด ๊ฐ์.
  // ์ด ๊ฒฝ์ฐ ๋์ ์ฐจ์ด์ ์ ๋ฌด์์ผ๊น?
}

example(name: "answer. flatMap") {
  struct Student{
    var score: BehaviorSubject<Int>
  }
  
  // Student ํ์์ ๋ณ์ 2๊ฐ๋ฅผ ์์ฑ ryan์ 80, charlotte๋ 90์ผ๋ก ์ด๊ธฐํ ๋์ด์๋ค.
  let ryan = Student(score: BehaviorSubject(value: 80))
  let charlotte = Student(score: BehaviorSubject(value: 90))
  
  let student = PublishSubject<Student>()
  
  // student์ ์ํ์ค๋ฅผ ๋ณํํ๋ค.
  student
  // Student ์์ Observable<Int>์ผ๋ก ๋ณํ
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
// ๊ธฐ์กด ์ต์ ๋ฒ๋ธ์ด ๋์ํ๊ณ  ์๋ ๋์ค์ ์๋ก์ด ์ต์ ๋ฒ๋ธ์ด ์ ๋ฌ๋๋ฉด ๊ธฐ์กด๊ฒ์ ๋๊ธฐ๊ฒ ๋๋ ๊ฒ์ ์ ์ธํ๊ณ ๋ flatMap๊ณผ ๋์์ด ๋๊ฐ์.
example(name: "flatMapLatest") {
  struct Student{
    var score: BehaviorSubject<Int>
  }
  
  // Student ํ์์ ๋ณ์ 2๊ฐ๋ฅผ ์์ฑ ryan์ 80, charlotte๋ 90์ผ๋ก ์ด๊ธฐํ ๋์ด์๋ค.
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
  // ์ฌ๊ธฐ์๋ถํฐ๋ ryan ์ํ์ค๋ ๋ฌด์๋๋ค.
  student.onNext(charlotte)
  
  // ์๋ ๋๋ฝ๋จ
  ryan.score.onNext(95)
  
  charlotte.score.onNext(100)
  /*
   80
   85
   90
   100
   */
}

// ๋คํธ์ํฌ ํต์ ์์ ๋ง์ด ์ฌ์ฉ๋จ.
// ์๋ฅผ ๋ค์ด ๊ฒ์์ด ์๋์์ฑ ๊ฐ์ด G๋ง ์ณค์ ๋ ๋์ค๋ ๊ฒ๊ณผ GO๋ฅผ ์ณค์ ๋ ๋์ค๋ ๊ฒ์ด ๋ค๋ฅด๋ฏ
// ์ฌ์ฉ์๊ฐ ๋ง์ง๋ง์ ์น ๋ฌธ์์ด์ ๋ํด์ ์๋์์ฑ์ ์์ผ์ฃผ๋ ๊ฒ๊ณผ ๊ฐ์ ๊ธฐ๋ฅ์ ๊ตฌํํ  ์ ์๋ค.
// G์์ ์ด์ด์ง๋ ๋์์ด ๋๊ธฐ๊ณ  ๋ง์ง๋ง์ ๋ฐฉ์ถ๋ GO๋ก ์ด์ด์ง๋ ๋์๋ง ์ด์์๋ ๊ฒ
// http://minsone.github.io/programming/reactive-swift-observable-chaining-async-task
// https://ntomios.tistory.com/11
example(name: "network with flatMapLatest") {
  
}

// MARK: - filter
// ์กฐ๊ฑด์ ํด๋นํ๋ ๊ฐ๋ง ๋ฐฉ์ถ
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
// ๋ช๊ฐ์ ์๋ฆฌ๋จผํธ๋ฅผ ๊ฐ์ ธ์ฌ์ง ์ ํด์ค๋ค.
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
// ์กฐ๊ฑด์์ด false๊ฐ ๋๊ธฐ ์ ๊น์ง๋ ๋ฐฉ์ถํ๊ณ  false๊ฐ ๋๋ฉด ๋ค๋ก๋ ๋ฌด์
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
// ์ด๋ค ๋ค๋ฅธ ์ต์ ๋ฒ๋ธ์ ์คํ์ด ์๊ธฐ์ ๊น์ง ๊ฐ์ ธ์ค๊ณ  ๊ทธ ๋ค๋ก  ์ข๋ฃ
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
// Observable ์ํ์ค ์์ ๊ฐ์ ์ถ๊ฐํด์ค๋ค.
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
// Observable ์ํ์ค๋ฅผ ์์์์ด ํฉ์ณ์ค๋ค.
// 1๋ฒ 2๋ฒ Observable์ด ์๋ค๊ณ  ํ์ ๋ 1๋ฒ ์ํ์ค ๋ฐฉ์ถ ํ๊ณ  2๋ฒ ์ํ์ค ๋ฐฉ์ถ์ด ์๋๋ผ ์ํ์ค์ ๋ํด ์์๊ฐ ์์ด ๊ทธ๋ฅ ํ๋ฆ๋๋ก ํฉ์ณ์ค๋ค.
example(name: "merge") {
  let left = Observable.of("0", "1")
  let right = Observable.of("zero", "one")
  
//  let source = Observable.of(left, right)
  
  // ์ด๋ ๊ฒ ํด๋ ๋จ
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
// ๊ฐ๊ธฐ ๋๊ฐ์ Observable์ ํฉ์ฑํ๋ค. ๋ค๋ง ์ฒซ๋ฒ์งธ Observable์ ์ด๋ฒคํธ๊ฐ ๋ฐ์ํด์ผ ์ง๋ง 2๊ฐ๋ฅผ ๋ฌถ์ด์ ์ต์ข ์ํ์ค๋ก ์ ๋ฌํ๋ค.
// ์ฒซ๋ฒ์งธ ์ด๋ฒคํธ๊ฐ ์๋ค๋ฉด ์ต์ข์ํ์ค๋ก ์ ๋ฌx

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
  
  // ๋ฐฉ์ถx
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
  
  // textField์ ์๋ ฅ์ค
  textField.onNext("Par")
  textField.onNext("Pari")
  textField.onNext("Paris")
  
  // ๋ค ์๋ ฅํ๊ณ  ๋ฒํผ์ ๋๋ฒ ํญ
  button.onNext(())
  button.onNext(())
  
  /*
   Paris
   Paris
   */
}

// MARK: - combineLatest
// https://rhammer.tistory.com/311?category=649741
// 2๊ฐ์ Observable์ ๊ฐ๊ฐ์ ์ด๋ฒคํธ๊ฐ ๋ฐ์ํ์ ๋ ์ต์ ์ด๋ฒคํธ๋ผ๋ฆฌ ๋ฌถ์ด์ ์ต์ข ์ํ์ค์ ์ ๋ฌํ๋ค.

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
  
  // ๊ถ๊ธํ๊ฑฐ ์ง๊ธ์ ์๊ฐ์์์ .short, .long ์ํ์ค ์ฌ์ด์ Date() ์๋ฆฌ๋จผํธ๊ฐ ๋ฐฉ์ถ๋์ .short, Date() / .long, Date() ์์ผ๋ก ๋ฌถ์์ง๋ง,
  // .short, .long ์ํ์ค ์ดํ์ Date() ์๋ฆฌ๋จผํธ๊ฐ ๋ฐฉ์ถ๋๋ฉด..?
  // -> ๋น์ฐํ .long, Date() ์์ผ๋ก๋ง ๋ฌถ์ผ ๊ฒ์. ๊ทธ๋์ combineLatest ์ด๋ฐ ๊ฒฝ์ฐ๊ฐ ์์๊ธด๋ค๋ ๋ณด์ฅํ์ ์จ์ผ ํจ
}

// MARK: - throttle
// https://eunjin3786.tistory.com/80
// https://opendoorlife.tistory.com/19
// ์ง์ ๋ ์๊ฐ๋์ Observable์ด ๋ด๋ณด๋ธ ์ฒซ๋ฒ์งธ ์๋ฆฌ๋จผํธ์ ๋ง์ง๋ง ์๋ฆฌ๋จผํธ(latest ์ ๋ฐ๋ผ ๋ค๋ฆ)๋ฅผ ๋ด๋ณด๋ด๋ Observable์ ๋ฐํํ๋ค.
// ์ด ์ฐ์ฐ์๋ DueTime๋ณด๋ค ์งง์ ์๊ฐ์ ๋๊ฐ์ ์์๊ฐ ๋ด๋ณด๋ด์ง์ง ์๋๋ก ํ๋ค.
// (์ฐธ๊ณ : ๋ฐฉ์ถํ๋ฉด throttle ํ์ด๋จธ ํ๋ฌ๊ฐ)
// ์ง์ ๋ ์๊ฐ์์ ์๋ง์ ์ด๋ฒคํธ๊ฐ ๋ฐ์ํด๋ 2๊ฐ ์ด์ ์์๊ฐ ๋ฐฉ์ถ๋์ง ์๋๋ค๋ ์๊ธฐ
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
// ์ง์ ๋ ์๊ฐ๊ฐ๊ฒฉ ๋ด์ ๋ง์ง๋ง ํ๋์ source ์ด๋ฒคํธ๋ฅผ ์ต์ข ์ํ์ค์ ๋ฐฉ์ถํ๋ค. source ์ด๋ฒคํธ๊ฐ ๋ฐฉ์ถ๋  ๋๋ง๋ค ํ์ด๋จธ๋ ์ด๊ธฐํ๋๋ค.
//example(name: "debounce") {
//  Observable<Int>
//    .interval(.seconds(2), scheduler: MainScheduler.instance)
//    .take(3)
//    .debounce(.seconds(1), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//      print($0)
//    })
//    .disposed(by: disposeBag)
//  /*
//   0
//   1
//   2
//   */
//}

// MARK: - share
// https://jusung.github.io/shareReplay/
// https://rhammer.tistory.com/307?category=649741
// share๋ ๋์ผํ ์ฌ๋ฌ Observable์ ๋ํด ํ๋์ ์ํ์ค๋ง ์์ฑํด์ค๋ค.
// ์ฆ, ๋ฆฌ์์ค ๋น์ฉ์ ์ค์ฌ์ค๋ค.
example(name: "share") {
  let observable = PublishSubject<Int>()
  
  let reulst = observable.debug().share()
  
  reulst
    .map{ $0 * 2 }
    .subscribe(onNext:{
      print($0)
    })
    .disposed(by: disposeBag)
  
  reulst
    .map{ $0 * 3 }
    .subscribe(onNext:{
      print($0)
    })
    .disposed(by: disposeBag)
  observable.onNext(1)
}
