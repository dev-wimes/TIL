//
//  ViewModel.swift
//  MultiSectionCollectionView
//
//  Created by Wimes on 2022/03/18.
//

import Foundation

import RxSwift
import RxRelay

class ViewModel {
    private let disposeBag = DisposeBag()
    
    private let section1Relay = PublishRelay<[String]>()
    private let section2Relay = PublishRelay<[String]>()
    
    let sections: PublishRelay<[MySectionModel]> = .init()
    
    func bind() {
        Observable.combineLatest(self.section1Relay, self.section2Relay)
            .map{ (a, b) in
                var arr = [MySectionModel]()
                
                let item = a.map{ MySectionModel.Item.section1Item(title: $0) }
                let item2 = b.map{ MySectionModel.Item.section2Item(title: $0) }
                
                let mySectionModel1 = MySectionModel.section1(items: item)
                let mySectionModel2 = MySectionModel.section2(items: item2)
                
                arr.append(mySectionModel1)
                arr.append(mySectionModel2)
                
                return arr
            }
            .bind(to: self.sections)
            .disposed(by: disposeBag)
        
        self.section1Relay.accept(["1", "2", "3"])
        self.section2Relay.accept(["a", "b", "c"])
    }
}
