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
  }
  
  struct Output {
    var tableViewDataSourceRelay: PublishRelay<[String]>
  }
  
  init() { }
  
  func transform(input: Input) -> Output{
    let tableViewDataSourceRelay = PublishRelay<[String]>()
    
    input.viewDidLoadTrigger
      .withUnretained(self)
      .map { owner, _ in
        return owner.tableViewDataSource
      }
      .bind(onNext: { dataSource in
        tableViewDataSourceRelay.accept(dataSource)
      })
      .disposed(by: self.disposeBag)
    
    
    
    return Output(tableViewDataSourceRelay: tableViewDataSourceRelay)
  }
}
