//
//  ViewController.swift
//  ShareTest
//
//  Created by Wimes on 2022/03/09.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController{
  let disposeBag = DisposeBag()
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var button: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let rx = Observable.of(100).debug("##")
      
    let result = button.rx.tap
      .flatMap{rx}
      .share()
    result
      .map{$0>0}
      .bind(to: button.rx.isHidden)
      .disposed(by: disposeBag)
      
    
    result
      .map { "\($0)" }
      .bind(to: label.rx.text)
      .disposed(by: disposeBag)
  }
}

