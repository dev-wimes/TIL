import Foundation

public enum Direction {
  case left
  case right
}

public class TreeNode<T> {
  public var value: T?
  public var left: TreeNode?
  public var right: TreeNode?
  
  public init(value: T?, left: TreeNode? = nil, right: TreeNode? = nil) {
    self.value = value
    self.left = left
    self.right = right
  }
}
