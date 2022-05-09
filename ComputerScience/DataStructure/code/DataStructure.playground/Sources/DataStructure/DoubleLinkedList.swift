import Foundation

public class DoubleLinkedList<T: Equatable> {
  private var head: Node<T>? = Node(value: nil, next: nil, prev: nil)
  private var tail: Node<T>? = Node(value: nil, next: nil, prev: nil)
  
  public var values: [T?] {
    var array: [T?] = []
    if self.head == nil { return [] }
    
    var node = self.head
    array.append(node?.value)
    
    while node?.next != nil {
      node = node?.next
      array.append(node?.value)
    }
    
    return array
  }
  
  public init() {
    self.head?.next = self.tail
    self.tail?.prev = self.head
  }
  
  private func increaseLoop(destination: Int? = nil) -> Node<T>? {
    let firstNode = self.head?.next
    var countingNode = firstNode
    
    if let destination = destination {
      if destination == 0 {
        return firstNode
      }
      for _ in 0 ..< destination {
        if countingNode?.next?.next == nil { return nil }
        countingNode = countingNode?.next
      }
      
    } else {
      while countingNode?.next != nil {
        countingNode = countingNode?.next
      }
    }
    
    return countingNode
  }
  
  // count도 구해야 해서 o(n^2) 이 나옴 구현하지 않는다.
//  private func decreaseLoop(destination: Int = 0) -> Node<T>? {
//    let lastNode = self.tail?.prev
//    var countingNode = lastNode
//
//
//
//    return countingNode
//  }
  
  // 삽입
  public func insert(index: Int, value: T) {
    if index < 0 { return }
    
    let newNode = Node(value: value)
    
    let purposeNode = self.increaseLoop(destination: index)
    let prevNode = purposeNode?.prev
    prevNode?.next = newNode
    newNode.prev = prevNode
    newNode.next = purposeNode
    purposeNode?.prev = newNode
  }
  
  // 생성
  public func create(_ value: T) {
    let lastNode = self.tail?.prev
    let newNode = Node(value: value, next: self.tail, prev: lastNode)
    lastNode?.next = newNode
    self.tail?.prev = newNode
  }
  
  // 삭제
  public func delete(at index: Int) -> T? {
    guard let purposeNode = self.increaseLoop(destination: index) else { return nil }
    
    let prevNode = purposeNode.prev
    let nextNode = purposeNode.next
    
    prevNode?.next = nextNode
    nextNode?.prev = prevNode
    purposeNode.next = nil
    purposeNode.prev = nil
    
    return purposeNode.value
  }
  
  public func removeLast() -> T? {
    let lastNode = self.tail?.prev
    guard let lastNodeValue = lastNode?.value else { return nil }
    
    let prevNode = lastNode?.prev
    prevNode?.next = self.tail
    self.tail?.prev = prevNode
    lastNode?.next = nil
    lastNode?.prev = nil
    
    return lastNodeValue
  }
  
  // 탐색
  public func search(_ value: T, increase: Bool) -> [Int] {
    var foundIndexs: [Int] = []
    
    if increase {
      var firstNode = self.head?.next
      var count = 0
      while firstNode?.value != nil {
        if value == firstNode?.value {
          foundIndexs.append(count)
        }
        firstNode = firstNode?.next
        count += 1
      }
    } else {
      var lastNode = self.tail?.prev
      var count = 0
      while lastNode?.value != nil {
        if value == lastNode?.value {
          foundIndexs.append(count)
        }
        lastNode = lastNode?.prev
        count += 1
      }
      foundIndexs = foundIndexs.map { count - $0 - 1 }
    }
    return foundIndexs
  }
}
