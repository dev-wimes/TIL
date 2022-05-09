import Foundation

public class SingleLinkedList<T: Equatable> {
  private var head: Node<T>? = nil
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
  
  private func isAvailableIndex(_ index: Int) -> Bool {
    var node = self.head
    for _ in 0 ..< index - 1 {
      if node?.next?.next == nil { return false }
      node = node?.next
    }
    
    return true
  }
  
  public init() { }
  
  // 생성
  public func create(_ value: T) {
    if self.head == nil {
      self.head = Node(value: value)
      return
    }
    
    var node = self.head
    while node?.next != nil {
      node = node?.next
    }
    node?.next = Node(value: value)
  }
  
  // 삭제
  public func delete(at index: Int) -> T? {
    if self.head == nil {
      return nil
    }
    
    if index == 0 {
      let deletingValue = self.head?.value
      self.head = self.head?.next
      self.head?.next = nil
      
      return deletingValue
    }
    
    if !self.isAvailableIndex(index) {
      return nil
    }
    
    var prevNode = self.head
    for _ in 0 ..< index - 1 {
      prevNode = prevNode?.next
    }
    
    
    let deletingNode = prevNode?.next
    prevNode?.next = deletingNode?.next
    deletingNode?.next = nil
    
    return deletingNode?.value
  }
  
  public func removeLast() -> T? {
    if self.head == nil {
      return nil
    }
    
    var node = self.head
    while node?.next?.next != nil {
      node = node?.next
    }
    
    let removedValue = node?.next?.value
    node?.next = nil
    
    return removedValue
  }
  
  // 삽입
  public func insert(index: Int, value: T) {
    if index < 0 { return }
    
    let newNode = Node(value: value)
    
    if index == 0 {
      newNode.next = self.head
      self.head = newNode
      return
    }
    
    if !self.isAvailableIndex(index) {
      return
    }
    
    var prevNode = self.head
    for _ in 0 ..< index - 1 {
      prevNode = prevNode?.next
    }
    newNode.next = prevNode?.next
    prevNode?.next = newNode
  }
  
  // 탐색
  public func search(_ value: T) -> [Int] {
    var foundIndexs: [Int] = []
    
    var node = self.head
    var count = 0
    while node != nil {
      if value == node?.value {
        foundIndexs.append(count)
      }
      node = node?.next
      count += 1
    }
    
    return foundIndexs
  }
}
