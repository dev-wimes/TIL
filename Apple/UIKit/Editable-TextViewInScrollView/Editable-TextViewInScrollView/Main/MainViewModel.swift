//
//  MainViewModel.swift
//  Editable-TextViewInScrollView
//
//  Created by Wimes on 2022/05/14.
//

import Foundation

import RxSwift
import RxRelay

final class MainViewModel {
  
  private let disposeBag = DisposeBag()
  
  private let tableViewDataSource: [String] = [
    "normal", "disable TextView animation"
  ]
  
  struct Input {
    var viewDidLoadTrigger: PublishRelay<Void>
    var itemSelectedTrigger: PublishRelay<IndexPath>
  }
  
  struct Output {
    var tableViewDataSourceRelay: PublishRelay<[String]>
    var pushEditViewControllerRelay: PublishRelay<EditViewModel>
  }
  
  init() { }
  
  func transform(input: Input) -> Output{
    // output
    let tableViewDataSourceRelay = PublishRelay<[String]>()
    let pushEditViewControllerRelay = PublishRelay<EditViewModel>()
    
    
    // input
    input.viewDidLoadTrigger
      .withUnretained(self)
      .map { owner, _ in
        return owner.tableViewDataSource
      }
      .bind(onNext: { dataSource in
        tableViewDataSourceRelay.accept(dataSource)
      })
      .disposed(by: self.disposeBag)
    
    input.itemSelectedTrigger
      .withUnretained(self)
      .bind { owner, indexPath in
        let viewModel: EditViewModel
        
        switch indexPath.row {
        case 0:
          viewModel = EditViewModel(disableTextViewAnimation: true)
        case 1:
          viewModel = EditViewModel(disableTextViewAnimation: false)
        default:
          return
        }
        
        pushEditViewControllerRelay.accept(viewModel)
      }
      .disposed(by: self.disposeBag)
    
    
    return Output(tableViewDataSourceRelay: tableViewDataSourceRelay, pushEditViewControllerRelay: pushEditViewControllerRelay)
  }
}
