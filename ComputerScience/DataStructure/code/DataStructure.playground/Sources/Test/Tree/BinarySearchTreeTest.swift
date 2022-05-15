import Foundation
import XCTest

public class BinarySearchTreeTest: XCTestCase {
  public func test_insert() {
    let binSTree = BinarySearchTree(rootValue: 30)
    let root = binSTree.root
    
    // level 1
    binSTree.insertValue(50, parentNode: root)
    binSTree.insertValue(20, parentNode: root)
    
    // level 2
    binSTree.insertValue(10, parentNode: root)
    binSTree.insertValue(25, parentNode: root)
    binSTree.insertValue(40, parentNode: root)
    binSTree.insertValue(70, parentNode: root)
    
    print("@@ \(#function) levelorder: ", binSTree.levelOrderDescription)
    XCTAssertEqual([30, 20, 50, 10, 25, 40, 70], binSTree.levelOrderDescription)
  }
  
  public func test_remove() {
    let binSTree = BinarySearchTree(rootValue: 30)
    let root = binSTree.root
    
    // level 1
    binSTree.insertValue(50, parentNode: root)
    binSTree.insertValue(20, parentNode: root)
    
    // level 2
    binSTree.insertValue(10, parentNode: root)
    binSTree.insertValue(25, parentNode: root)
    binSTree.insertValue(40, parentNode: root)
    binSTree.insertValue(70, parentNode: root)
    
    // remove
    binSTree.removeValue(20, parentNode: root)
    
    print("@@ \(#function) levelorder: ", binSTree.levelOrderDescription)
    XCTAssertEqual([30, 50, 40, 70], binSTree.levelOrderDescription)
  }
  
  public func test_removeRoot() {
    let binSTree = BinarySearchTree(rootValue: 30)
    let root = binSTree.root
    
    // level 1
    binSTree.insertValue(50, parentNode: root)
    binSTree.insertValue(20, parentNode: root)
    
    // level 2
    binSTree.insertValue(10, parentNode: root)
    binSTree.insertValue(25, parentNode: root)
    binSTree.insertValue(40, parentNode: root)
    binSTree.insertValue(70, parentNode: root)
    
    // remove
    binSTree.removeValue(30, parentNode: root)
    
    print("@@ \(#function) levelorder: ", binSTree.levelOrderDescription)
    XCTAssertEqual([], binSTree.levelOrderDescription)
  }
}
