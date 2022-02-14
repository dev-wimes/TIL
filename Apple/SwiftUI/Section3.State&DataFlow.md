# Section3. State & Data Flow

## 8. State & Data Flow - Part1

* SwiftUI의 장점은

  * UI가 functional하다는 것.
  * 상황을 엉망으로 만들 수 있는 중간 단계가 없으며
  * 특정 조건에 따라 View가 표시되어야 하는지 여부를 결정하기 위해 여러번 확인할 필요가 없음.
  * 상태변경이 있을 때 UI를 수동으로 새로 고치는 것을 기억할 필요가 없음.

* `State`는 SwiftUI에 있는 값을 읽고 쓸 수 있는 프로퍼티 래퍼 이다.

  * SwiftUI는 State로 선언한 모든 프로퍼티의 메모리를 관리한다. State 값이 변경되면 View가 다시 업데이트 한다.
  * 주어진 View에 대한 "single source of turth"로 State를 사용함.

* 아래 두개는 같은 동작

  ```swift
  var _numberOfAnswered = State<Int>(initialValue: 0)
  ...
  self._numberOfAnswered.wrappedValue += 1
  ...
  Text("\(_numberOfAnswered.wrappedValue)")
  ```

  ```swift
  @State var numberOfAnswered = 0
  ...
  self.numberOfAnswered += 1
  ...
  Text("\(numberOfAnswered)")
  ```

* SwiftUI의 방식은 데이터가 아닌 레퍼런스를 소유하고 있다.

  SwiftUI는 선언적 접근 방식을 사용하고 State 프로퍼티의 반응형 특성을 활용하여 State 프로퍼티가 변경될 때 UI를 자동으로 업데이트한다.

  SwiftUI는 데이터를 소유하지 않는다. 다른 곳에 저장된 데이터에 대한 레퍼런스를 소유한다. 이를 통해 SwiftUI는 모델이 변경될 때 UI를 자동적으로 업데이트가 가능한 것. 어떤 component가 모델을 참조하는지 알고 있기 때문에 모델이 변경될 때 업데이트할 UI부분을 파악할 수 있다.

  이를 이용해 Binding을 사용한다.

* `Binding<T>`

  데이터를 저장하는 속성과 데이터를 표시하고 변경하는 View간의 양방향 연결임. 바인딩은 데이터를 직접 저장하는 대신 다른 곳에 저장된 "source of truth" 에 프로퍼티를 연결한다.

* 아래 코드가 의미하는 바

  ```swift
  var name: State<String> = State(initialValue: "")
  ...
  TextField("Type your name...", text: name.projectedValue)
  ```

  1. 사용자가 텍스트를 수정하면 `TextField`는 `name` State 프로퍼티의 바인딩을 사용하여 기본 데이터를 업데이트한다.
  2. 데이터가 변경되면 `name` State 프로퍼티는 데이터를 참조하는 모든 UI component에 대한 업데이트를 트리거한다.
  3. 텍스트 View는 업데이트 요청을 수신하고 이름의 wrapValue에 포함된 값을 다시 렌더링하여 내용을 업데이트한다.

  위 코드를 좀 더 깔끔하게 쓰면 아래와 같다.

  ```swift
  @State var name: String = ""
  TextField("Type your name...", text: $name)
  ```

  `@State`와 `$` 를 사

* single source of truth

  이 책을 포함하여 SwiftUI를 논의하는 모든 곳에서 이 용어를 볼 수 있다.
  데이터는 단일 entity만 소유해야 하고 다른 모든 entity는 복사본이 아니라 동일한 데이터에 엑세스해야 한다는 뜻임.

  값 타입을 전달하면 원본에 영향을 주지 않음.

  이는 State를 변경할 때 해당 변경 사항이 UI를 자동적으로 업데이트를 시킬 수 없다.따라서 데이터의 이동이 일어날 때마다 데이터의 참조를 전달한다.

  SwiftUI에서는 single source를 연결한 동작이 있는 참조 타입으로 생각하면 된다.

