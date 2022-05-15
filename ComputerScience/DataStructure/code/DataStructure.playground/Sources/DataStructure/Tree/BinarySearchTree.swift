import Foundation

final class BinarySearchTree: BinaryTreeType {
  public var root: TreeNode<Int>
  
  public init(rootValue: Int) {
    self.root = TreeNode(value: rootValue)
  }
  
  public func insertValue(_ value: Int, parentNode: TreeNode<Int>) {
    if let parentNodeValue = parentNode.value {
      if parentNodeValue == value { return }
      
      if parentNodeValue > value {
        guard let leftNode = parentNode.left else {
          parentNode.left = TreeNode(value: value)
          return
        }
        
        self.insertValue(value, parentNode: leftNode)
      } else if parentNodeValue < value {
        guard let rightNode = parentNode.right else {
          parentNode.right = TreeNode(value: value)
          return
        }
        
        self.insertValue(value, parentNode: rightNode)
      }
    }
  }
  
  public func removeValue(_ value: Int, parentNode: TreeNode<Int>) {
    if let rootValue = root.value,
       rootValue == value {
      self.root = TreeNode(value: nil, left: nil, right: nil)
    }
    
    guard let parentNodeValue = parentNode.value else { return }
    
    if parentNodeValue > value {
      guard let leftNode = parentNode.left,
            let leftNodeValue = leftNode.value
      else { return }
      if value == leftNodeValue {
        parentNode.left = nil
        return
      }
      
      self.removeValue(value, parentNode: leftNode)
      
    } else if parentNodeValue < value {
      guard let rightNode = parentNode.right,
            let rightNodeValue = rightNode.value
      else { return }
      if value == rightNodeValue {
        parentNode.right = nil
        return
      }
      
      self.removeValue(value, parentNode: rightNode)
    }
  }
  
  // swift는 받아온 값에 대한 포인터에 접근이 안되서 쓸 일 없음
//  @discardableResult
//  private func searchValue(_ value: Int, parentNode: TreeNode<Int>) -> TreeNode<Int>? {
//    guard let parentNodeValue = parentNode.value else { return nil }
//    if parentNodeValue == value { return parentNode }
//
//    if parentNodeValue > value {
//      guard let leftNode = parentNode.left else { return nil }
//      self.searchValue(value, parentNode: leftNode)
//    } else {
//      guard let rightNode = parentNode.right else { return nil}
//      self.searchValue(value, parentNode: rightNode)
//    }
//
//    return nil
//  }
}
