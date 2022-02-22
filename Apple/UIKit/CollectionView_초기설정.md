# CollectionView_초기설정

## 개요

CollectionView를 사용하다 잘못된 초기설정으로 인해 이상한 곳에서 삽질을 할 수 있다.

이를 미연에 방지하고자 한다.

처음 내가 CollectionView를 만들었을 때 코드는 다음과 같다.

```swift
let collectionView = UICollectionView(
  frame: .zero,
  collectionViewLayout: UICollectionViewLayout()
).then{
  $0.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.ID)
}

...

func bind(){
  output.pokemons
  .debug("### ")
  .drive(self.collectionView.rx.items(
    cellIdentifier: HomeCell.ID,
    cellType: HomeCell.self)
	){ _, pokemonSummaryResult, cell in
  	print(pokemonSummaryResult)
    cell.configure(pokemonSummaryResult: pokemonSummaryResult)
  }
  .disposed(by: self.disposeBag)
}
```

실행했을 때 event는 제대로 방출을 하고 있는데

![image-20220222230918421](CollectionView_초기설정.assets/image-20220222230918421.png)

```swift
print(pokemonSummaryResult)
```

으로 인한 출력은 도통되지 않는다. 즉, drive를 이용한 스트림이 흐르지 않는다는 얘기.

## 해결

Rx쪽을 잘못 작성했나 싶어서 그 부분을 찾아보고 있었는데 문제는 UIKit CollectionView 초기화가 문제였다.

```swift
let collectionView = UICollectionView(
  frame: .zero,
  collectionViewLayout: UICollectionViewLayout()
).then{
  $0.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.ID)
}
```

여기서 `UICollectionViewLayout()` 을 생성하고 있는데, `UICollectionViewFlowLayout()`를 써야 한다.

```swift
let collectionView = UICollectionView(
  frame: .zero,
  collectionViewLayout: UICollectionViewFlowLayout()
).then{
  $0.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.ID)
}
```

[UICollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout)을 보면 abstract base class로 소개한다. 즉, 추상클래스고, 아무것도 하지 않는다.

View가 제대로 생성이 안되었으니, 해당 스트림은 drive부터 흐르지 않는다.

제대로 된 layout을 갖게 하려면 [UICollectionFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout)을 사용해야 한다.

## Reference

* https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout
* https://developer.apple.com/documentation/uikit/uicollectionviewlayout
* UICollectionView/dequeueReusableCellWithIdentifier관련해서 읽어보면 좋은 글
  * https://sihyungyou.github.io/iOS-dequeueReusableCell/