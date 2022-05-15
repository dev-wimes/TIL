import Foundation

public protocol BinaryTreeType {
  associatedtype Element: Equatable
  
  var root: TreeNode<Element> { get }
  
  func insertChild(
    node parentNode: TreeNode<Element>,
    value: Element,
    direction: Direction
  ) -> TreeNode<Element>
  
  func removeChid(
    node parentNode: TreeNode<Element>,
    direction: Direction
  ) -> Element?
}

extension BinaryTreeType {
  // 전위
  public var prefixDescription: [Element] {
    var resultArray: [Element] = []
    self.prefixFunction(root: self.root, tempArray: &resultArray)
    return resultArray
  }
  
  private func prefixFunction(root: TreeNode<Element>?, tempArray: inout [Element]) {
    guard let root = root,
          let rootValue = root.value
    else { return }
    
    tempArray.append(rootValue)
    if root.left != nil {
      self.prefixFunction(root: root.left, tempArray: &tempArray)
    }
    if root.right != nil {
      self.prefixFunction(root: root.right, tempArray: &tempArray)
    }
  }
  
  // 중위
  var infixDescription: [Element] {
    var resultArray: [Element] = []
    self.infixFunction(root: self.root, tempArray: &resultArray)
    return resultArray
  }

  private func infixFunction(root: TreeNode<Element>?, tempArray: inout [Element]) {
    guard let root = root,
          let rootValue = root.value
    else { return }
    
    if root.left != nil {
      self.infixFunction(root: root.left, tempArray: &tempArray)
    }
    tempArray.append(rootValue)
    if root.right != nil {
      self.infixFunction(root: root.right, tempArray: &tempArray)
    }
  }

  // 후위
  var postfixDescription: [Element] {
    var resultArray: [Element] = []
    self.postfixFunction(root: self.root, tempArray: &resultArray)
    return resultArray
  }

  private func postfixFunction(root: TreeNode<Element>?, tempArray: inout [Element]) {
    guard let root = root,
          let rootValue = root.value
    else { return }
    
    if root.left != nil {
      self.postfixFunction(root: root.left, tempArray: &tempArray)
    }
    
    if root.right != nil {
      self.postfixFunction(root: root.right, tempArray: &tempArray)
    }
    tempArray.append(rootValue)
  }
  
  // 레벨
  var levelOrderDescription: [Element] {
    var resultArray: [Element] = []
    self.levelOrderDescription(root: self.root, tempArray: &resultArray)
    return resultArray
  }
  
  private func levelOrderDescription(root: TreeNode<Element>?, tempArray: inout [Element]) {
    guard let root = root else { return }
    
    let queue = Queue<TreeNode<Element>>()
    queue.push(value: root)
    
    while !queue.isEmpty() {
      guard let pop = queue.pop(),
            let popValue = pop.value
      else { return }
      tempArray.append(popValue)
      
      if pop.left != nil {
        guard let left = pop.left else { return }
        queue.push(value: left)
      }
      
      if pop.right != nil {
        guard let right = pop.right else { return }
        queue.push(value: right)
      }
    }
  }
}
