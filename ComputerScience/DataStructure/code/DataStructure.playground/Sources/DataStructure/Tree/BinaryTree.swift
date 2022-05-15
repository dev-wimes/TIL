import Foundation

public class BinaryTree<T: Equatable>: BinaryTreeType {
  public var root: TreeNode<T>
  
  public init(rootValue: T) {
    self.root = TreeNode(value: rootValue)
  }
  
  @discardableResult
  public func insertChild(
    node parentNode: TreeNode<T>,
    value: T,
    direction: Direction
  ) -> TreeNode<T> {
    let newNode = TreeNode(value: value)
    
    if direction == .left {
      if parentNode.left != nil { return TreeNode(value: nil) }
      parentNode.left = newNode
    } else if direction == .right {
      if parentNode.right != nil { return TreeNode(value: nil) }
      parentNode.right = newNode
    }
    
    return newNode
  }
  
  @discardableResult
  public func removeChid(
    node parentNode: TreeNode<T>,
    direction: Direction
  ) -> T? {
    var deleteValue: T?
    
    if direction == .left {
      if parentNode.left == nil { return nil }
      deleteValue = parentNode.left?.value
      parentNode.left = nil
    } else if direction == .right {
      if parentNode.right == nil { return nil }
      deleteValue = parentNode.right?.value
      parentNode.right = nil
    }
    
    return deleteValue
  }
}
