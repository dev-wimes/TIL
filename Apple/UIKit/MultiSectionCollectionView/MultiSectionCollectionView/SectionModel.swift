//
//  SectionModel.swift
//  MultiSectionCollectionView
//
//  Created by Wimes on 2022/03/19.
//

import Foundation
import RxDataSources

enum MySectionModel: SectionModelType {
    
    typealias Item = MySectionItem
    
    case section1(items: [MySectionItem])
    case section2(items: [MySectionItem])
    
    var items: [MySectionItem] {
        switch self {
        case .section1(items: let items):
            return items
        case .section2(items: let items):
            return items
        }
    }
    
    init(original: MySectionModel, items: [Item]) {
        switch original {
        case .section1(items: _):
            self = .section1(items: items)
        case .section2(items: _):
            self = .section2(items: items)
        }
    }
}

enum MySectionItem {
    case section1Item(title: String)
    case section2Item(title: String)
}
