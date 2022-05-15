//
//  EditViewController.swift
//  Editable-TextViewInScrollView
//
//  Created by Wimes on 2022/05/15.
//

import UIKit

import RxSwift
import RxCocoa
import RxRelay
import SnapKit

final class EditViewController: UIViewController {

  private let disposedBag = DisposeBag()
  private let viewModel: EditViewModel
  
  private let scrollView = UIScrollView()
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 0
    stackView.distribution = .fillEqually
    return stackView
  }()
  private let textContentView = UIView()
  private let textView: UITextView = {
    let textView = UITextView()
    
    textView.isScrollEnabled = false
    
    return textView
  }()
  private let bottomView = UIView()
  private let button = UIButton(type: .system)
  
  init(viewModel: EditViewModel = EditViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    self.bind()
  }
  
  required init?(coder: NSCoder) {
    self.viewModel = EditViewModel()
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    self.bind()
    self.configureUI()
  }
  
  private func bind() {
    
  }
  
  private func configureUI() {
    // bottom view
    self.view.addSubview(self.bottomView)
    self.bottomView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
    }
    self.button.backgroundColor = .lightGray
    self.bottomView.addSubview(self.button)
    self.button.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
      make.height.equalTo(50)
      make.top.bottom.equalToSuperview()
      make.centerX.equalToSuperview()
    }
    
    // scroll view
    self.scrollView.showsHorizontalScrollIndicator = false
    self.view.addSubview(self.scrollView)
    self.scrollView.snp.makeConstraints { make in
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.bottom.equalTo(self.bottomView.snp.top)
      make.width.centerX.equalToSuperview()
    }
    
    self.scrollView.addSubview(self.stackView)
    self.stackView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.width.centerX.equalToSuperview()
    }
    
    self.scrollView.contentLayoutGuide.snp.makeConstraints { make in
      make.width.equalTo(self.stackView)
    }
    
    self.stackView.addArrangedSubview(self.textContentView)
    self.textView.backgroundColor = .lightGray
    self.textContentView.addSubview(self.textView)
    self.textView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.height.greaterThanOrEqualTo(100)
      make.bottom.equalToSuperview().offset(-60)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
    
  }
}
