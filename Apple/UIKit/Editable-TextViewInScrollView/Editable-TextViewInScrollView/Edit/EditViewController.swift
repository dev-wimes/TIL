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
  }
  
  private func bind() {
    
  }
  
  private func configureUI() {
    
  }
}
