//
//  Section2Cell.swift
//  MultiSectionCollectionView
//
//  Created by Wimes on 2022/03/18.
//

import UIKit

import SnapKit

class Section2Cell: UICollectionViewCell {
    static let ID: String = "Section2Cell"
    let label = UILabel()
    
    func configure(title: String) {
        self.setupLayout()
        
        label.text = title
    }
    
    func setupLayout() {
        self.contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
//        print("@@ ", layoutAttributes)
        return layoutAttributes
    }
}
