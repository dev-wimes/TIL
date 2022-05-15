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
  private let itemSelectedTrigger: PublishRelay<IndexPath> = .init()
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    
    tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.ID)
    
    return tableView
  }()
  
  init(viewModel: MainViewModel = MainViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    self.bind()
  }
  
  required init?(coder: NSCoder) {
    self.viewModel = MainViewModel()
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.viewDidLoadTrigger.accept(())
    
    self.configureUI()
  }
  
  private func bind() {
    // viewModel
    let output = self.viewModel.transform(input: .init(viewDidLoadTrigger: self.viewDidLoadTrigger, itemSelectedTrigger: self.itemSelectedTrigger))
    
    output.tableViewDataSourceRelay
      .bind(to: self.tableView.rx.items) { tableView, index, element in
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.ID) as? MainCell else {
          return UITableViewCell()
        }
        
        cell.configure(title: element)
        
        return cell
      }
      .disposed(by: self.disposeBag)
    
    output.pushEditViewControllerRelay
      .withUnretained(self)
      .bind { owner, viewModel in
        let vc = EditViewController(viewModel: viewModel)
        owner.navigationController?.pushViewController(vc, animated: true)
      }
      .disposed(by: self.disposeBag)
    
    // view
    self.tableView.rx.itemSelected
      .bind(to: self.itemSelectedTrigger)
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
