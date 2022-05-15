import Foundation

public class BinaryTree<T: Equatable> {
  private var root: TreeNode<T>? = nil
  
  public enum Direction {
    case left
    case right
  }
  
  public init(rootValue: T) {
    self.root = TreeNode(value: rootValue)
  }
  
  public func insertChild(
    node parentNode: TreeNode<T>,
    value: T,
    direction: Direction
  ) -> TreeNode<T>? {
    let newNode = TreeNode(value: value)
    
    if direction == .left {
      if parentNode.left != nil { return nil }
      parentNode.left = newNode
    } else if direction == .right {
      if parentNode.right != nil { return nil }
      parentNode.right = newNode
    }
    
    return newNode
  }
  
  public func removeChid(
    node parentNode: TreeNode<T>,
    direction: Direction
  ) -> T? {
    var deleteValue: T? = nil
    
    if direction == .left {
      if parentNode.left != nil { return nil }
      deleteValue = parentNode.value
      parentNode.left = nil
    } else if direction == .right {
      if parentNode.right != nil { return nil }
      deleteValue = parentNode.value
      parentNode.right = nil
    }
    
    return deleteValue
  }
}


// 순회
extension BinaryTree {
  // 전위
  var prefixDescription: String {
    ""
  }
  
  // 중위
  var infixDescription: String {
    ""
  }
  
  // 후위
  var postfixDescription: String {
    ""
  }
}
