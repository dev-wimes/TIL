//
//  EditViewModel.swift
//  Editable-TextViewInScrollView
//
//  Created by Wimes on 2022/05/15.
//

import Foundation


final class EditViewModel {
  var disableTextViewAnimation: Bool
  var hiddenBottomView: Bool
  
  init(disableTextViewAnimation: Bool = false, hiddenBottomView: Bool = true) {
    self.disableTextViewAnimation = disableTextViewAnimation
    self.hiddenBottomView = hiddenBottomView
  }
}
