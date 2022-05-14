//
//  MainViewController.swift
//  Editable-TextViewInScrollView
//
//  Created by Wimes on 2022/05/14.
//

import UIKit

import RxSwift
import RxCocoa
import RxRelay
import SnapKit

final class MainViewController: UIViewController {
  
  private let disposeBag = DisposeBag()
  private let viewModel: MainViewModel
  private let viewDidLoadTrigger: PublishRelay<Void> = .init()
  
  init(viewModel: MainViewModel = MainViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    self.bind()
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    self.viewModel = MainViewModel()
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    self.viewModel = MainViewModel()
    super.init(coder: coder)
  }
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    
    tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.ID)
    
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.viewDidLoadTrigger.accept(())
    
    self.configureUI()
  }
  
  private func bind() {
    
    let output = self.viewModel.transform(input: .init(viewDidLoadTrigger: self.viewDidLoadTrigger))
    
    output.tableViewDataSourceRelay
      .bind(to: self.tableView.rx.items) { tableView, index, element in
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.ID) as? MainCell else {
          return UITableViewCell()
        }
        
        cell.configure(title: element)
        
        return cell
      }
      .disposed(by: self.disposeBag)
  }
  
  private func configureUI() {
    self.title = "Main"
    
    self.tableView.rx.setDelegate(self)
      .disposed(by: self.disposeBag)
    
    self.view.addSubview(self.tableView)
    self.tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
}

extension MainViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
}
