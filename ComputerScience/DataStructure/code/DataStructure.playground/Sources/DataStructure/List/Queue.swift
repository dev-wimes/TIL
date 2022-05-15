import Foundation

public class Queue<T: Equatable> {
  
  private var head: ListNode<T>? = nil
  private var tail: ListNode<T>? = nil
  
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
  
  public init() { }
  
  private func isEmpty() -> Bool {
    return self.head == nil
  }
  
  public func push(value: T) {
    let newNode = ListNode(value: value)
    
    if self.isEmpty() {
      self.head = newNode
      self.tail = newNode
      return
    }
    
    let oldNode = self.tail
    oldNode?.next = newNode
    self.tail = newNode
  }
  
  public func pop() -> T? {
    if self.isEmpty() {
      return nil
    }
    
    let deletingNode = self.head
    let deleteValue = deletingNode?.value
    let nextNode = self.head?.next
    deletingNode?.next = nil
    self.head = nextNode
    
    if self.head == nil {
      self.tail = nil
    }
    
    return deleteValue
  }
}
