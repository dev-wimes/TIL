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
//    NotificationCenter.default.addObserver(
//      self,
//      selector: #selector(self.keyboardWillShow),
//      name: UIResponder.keyboardWillShowNotification,
//      object: nil
//    )
//    NotificationCenter.default.addObserver(
//      self,
//      selector: #selector(self.keyboardWillHide),
//      name: UIResponder.keyboardWillHideNotification,
//      object: nil
//    )
    
    self.customKeyboardInfo()
      .drive { [weak self] isShow, keyboardFrame, duration in
        guard let self = self else { return }
        
        let scrollViewBottomInset = isShow ? self.view.safeAreaLayoutGuide.layoutFrame.height - (keyboardFrame.height) : 0
        self.scrollView.contentInset.bottom = scrollViewBottomInset
      }
      .disposed(by: self.disposedBag)
    
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
    self.scrollView.keyboardDismissMode = .onDrag
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
  
  private func customKeyboardInfo() -> Driver<(isShow: Bool, height: CGRect, animationDuration: TimeInterval)> {
    return Observable
      .from([
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
          .map { notification in
            let userInfo = notification.userInfo
            let value = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
            let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0
            return (true, value, animationDuration)
          },
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
          .map { notification in
            let userInfo = notification.userInfo
            let value = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
            let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0
            return (true, value, animationDuration)
          }
      ])
      .merge()
      .asDriver(onErrorDriveWith: Driver.never())
  }
}

//extension EditViewController {
//  @objc func keyboardWillShow(_ notification: NSNotification) {
//
//  }
//
//  @objc func keyboardWillHide(_ notification: NSNotification) {
//
//  }
//}
