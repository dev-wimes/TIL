//
//  Section1HeaderView.swift
//  MultiSectionCollectionView
//
//  Created by Wimes on 2022/03/19.
//

import UIKit



class Section1HeaderView: UICollectionReusableView {
    static let ID: String = "Section1HeaderView"
    
    private let label = UILabel()
    
    func configure(title: String) {
        self.setupLayout()
        self.label.text = title
    }
    
    func setupLayout() {
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
