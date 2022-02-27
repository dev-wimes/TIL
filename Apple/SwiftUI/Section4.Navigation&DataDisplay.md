# Section4. Navigation & Data Display

## 13. Navigation

* 모든 플랫폼(iPadOS, iOS, ....)에서 통일화된 NavigationStyle을 원한다면 NavigationView에 `.navigationViewStyle(StackNavigationViewStyle())`을 추가한다.

  ```swift
  NavigationView{
    ...
  }
  .navigationViewStyle(StackNavigationViewStyle())
  ```

* ```swift
  VStack{
    ...
  }
  .frame(maxWidth: .infinity, ...)
  ```

  가능한 수평공간을 모두 채움

* Environment가  view 계층 구조를 통해 흐르도록 하려면 이를 NavigationView 내부의 View가 아니라 NavigationView에 추가해야 한다.

  ```swift
  NavigationView{
  	...  
  }
  .envrionmentObject(...)
  ```

  