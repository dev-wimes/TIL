//
//  MainCell.swift
//  Editable-TextViewInScrollView
//
//  Created by Wimes on 2022/05/14.
//

import UIKit

import SnapKit

class MainCell: UITableViewCell {
  
  static let ID: String = "MainCell"
  
  private let titleLabel = UILabel()
  
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupLayout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  private func setupLayout() {
    self.contentView.addSubview(self.titleLabel)
    self.titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
      make.centerX.centerY.equalToSuperview()
    }
  }
  
  func configure(title: String) {
    self.titleLabel.text = title
  }
  
}
