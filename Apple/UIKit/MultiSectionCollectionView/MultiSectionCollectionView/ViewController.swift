//
//  ViewController.swift
//  MultiSectionCollectionView
//
//  Created by Wimes on 2022/03/18.
//

import UIKit

import RxDataSources
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  
  typealias MySectionDataSource = RxCollectionViewSectionedReloadDataSource<MySectionModel>
  
  private let disposeBag = DisposeBag()
  
  private let vm = ViewModel()
  
  private lazy var collectionView: UICollectionView = {
    print("collectionView init")
    let layout = MultiSectionCollectionViewFlowLayout()
    
    layout.scrollDirection = .vertical
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("viewDidLoad")
    
    collectionView.register(Section1Cell.self, forCellWithReuseIdentifier: Section1Cell.ID)
    collectionView.register(Section2Cell.self, forCellWithReuseIdentifier: Section2Cell.ID)
    collectionView.register(Section1HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Section1HeaderView.ID)
    
    vm.sections
      .bind(to: collectionView.rx.items(dataSource: ViewController.dataSource))
      .disposed(by: disposeBag)
    
    self.vm.bind()
    
    self.view.addSubview(self.collectionView)
    self.collectionView.snp.makeConstraints { make in
      make.top.bottom.leading.trailing.equalToSuperview()
    }
    
    collectionView.rx.setDelegate(self).disposed(by: disposeBag)
  }
  
  
}

extension ViewController {
  
  private static var dataSource: MySectionDataSource {
    print("dataSource init")
    let configureCell: (
      CollectionViewSectionedDataSource<MySectionModel>,
      UICollectionView,
      IndexPath,
      MySectionModel.Item
    ) -> UICollectionViewCell = { dataSource, collectionView, indexPath, item in
      print("configureCell")
      switch dataSource[indexPath] {
      case .section1Item(title: let title):
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Section1Cell.ID, for: indexPath) as! Section1Cell
        cell.configure(title: title)
        return cell
      case .section2Item(title: let title):
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Section2Cell.ID, for: indexPath)  as! Section2Cell
        cell.configure(title: title)
        return cell
      }
    }
    
    let supplementrayView: (
      CollectionViewSectionedDataSource<MySectionModel>,
      UICollectionView,
      String,
      IndexPath
    ) -> UICollectionReusableView = { dataSource, collectionView, kind, indexPath in
      print("supplementrayView")
      switch dataSource[indexPath] {
      case .section1Item(_):
        print("supplementrayView.section1Item")
        switch kind {
        case UICollectionView.elementKindSectionHeader:
          let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Section1HeaderView.ID, for: indexPath) as! Section1HeaderView
          view.configure(title: "section1")
          return view
        case UICollectionView.elementKindSectionFooter:
          break
        default:
          break
        }
      case .section2Item(_):
        print("supplementrayView.section2Item")
        switch kind {
        case UICollectionView.elementKindSectionHeader:
          let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Section1HeaderView.ID, for: indexPath) as! Section1HeaderView
          view.configure(title: "section2")
          return view
        case UICollectionView.elementKindSectionFooter:
          break
        default:
          break
        }
      }
      
      let dummyView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Section1HeaderView.ID, for: indexPath) as! Section1HeaderView
      dummyView.frame.size.width = 0.0
      dummyView.frame.size.height = 0.0
      
      return dummyView
    }
    
    let dataSource = MySectionDataSource.init(
      configureCell: configureCell,
      configureSupplementaryView: supplementrayView
    )
    
    return dataSource
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: self.view.frame.size.width, height: 50)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 0.0
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 0.0
  }
  
}

