import Foundation
import XCTest

public class BinaryTreeTest: XCTestCase {
  public func test_insertChild() {
    let binTree = BinaryTree(rootValue: 0)
    let root = binTree.root
    let oneNode = binTree.insertChild(node: root, value: 1, direction: .left)
    let twoNode = binTree.insertChild(node: root, value: 2, direction: .right)
    let threeNode = binTree.insertChild(node: oneNode, value: 3, direction: .left)
    let fourNode = binTree.insertChild(node: oneNode, value: 4, direction: .right)
    binTree.insertChild(node: threeNode, value: 7, direction: .left)
    binTree.insertChild(node: threeNode, value: 8, direction: .right)
    binTree.insertChild(node: fourNode, value: 9, direction: .left)
    binTree.insertChild(node: fourNode, value: 10, direction: .right)
    let fiveNode = binTree.insertChild(node: twoNode, value: 5, direction: .left)
    binTree.insertChild(node: twoNode, value: 6, direction: .right)
    binTree.insertChild(node: fiveNode, value: 11, direction: .left)
    print("@@ \(#function) prefix: ", binTree.prefixDescription)
    print("@@ \(#function) infix: ", binTree.infixDescription)
    print("@@ \(#function) postfix: ", binTree.postfixDescription)
    print("@@ \(#function) levelorder: ", binTree.levelOrderDescription)
    XCTAssertEqual([0, 1, 3, 7, 8, 4, 9, 10, 2, 5, 11, 6], binTree.prefixDescription)
    XCTAssertEqual([7, 3, 8, 1, 9, 4, 10, 0, 11, 5, 2, 6], binTree.infixDescription)
    XCTAssertEqual([7, 8, 3, 9, 10, 4, 1, 11, 5, 6, 2, 0], binTree.postfixDescription)
    XCTAssertEqual([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], binTree.levelOrderDescription)
  }
  
  public func test_removeChild() {
    let binTree = BinaryTree(rootValue: 0)
    let root = binTree.root
    let oneNode = binTree.insertChild(node: root, value: 1, direction: .left)
    let twoNode = binTree.insertChild(node: root, value: 2, direction: .right)
    let threeNode = binTree.insertChild(node: oneNode, value: 3, direction: .left)
    let fourNode = binTree.insertChild(node: oneNode, value: 4, direction: .right)
    
    binTree.insertChild(node: threeNode, value: 7, direction: .left)
    binTree.insertChild(node: threeNode, value: 8, direction: .right)
    binTree.insertChild(node: fourNode, value: 9, direction: .left)
    binTree.insertChild(node: fourNode, value: 10, direction: .right)
    let fiveNode = binTree.insertChild(node: twoNode, value: 5, direction: .left)
    binTree.insertChild(node: twoNode, value: 6, direction: .right)
    binTree.insertChild(node: fiveNode, value: 11, direction: .left)
    
    // remove
    // remove threeNode
    binTree.removeChid(node: oneNode, direction: .left)
    print("@@ \(#function) prefix: ", binTree.prefixDescription)
    print("@@ \(#function) infix: ", binTree.infixDescription)
    print("@@ \(#function) postfix: ", binTree.postfixDescription)
    XCTAssertEqual([0, 1, 4, 9, 10, 2, 5, 11, 6], binTree.prefixDescription)
    XCTAssertEqual([1, 9, 4, 10, 0, 11, 5, 2, 6], binTree.infixDescription)
    XCTAssertEqual([9, 10, 4, 1, 11, 5, 6, 2, 0], binTree.postfixDescription)
  }
}
