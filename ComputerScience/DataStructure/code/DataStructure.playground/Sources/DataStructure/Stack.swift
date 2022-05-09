import Foundation

public class Stack<T: Equatable> {
  
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
  
  public init() { }
  
  private func isEmpty() -> Bool {
    return self.head == nil
  }
  
  public func push(value: T) {
    let newNode = Node(value: value)
    
    if self.isEmpty() {
      self.head = newNode
      return
    }
    
    let oldNode = self.head
    newNode.next = oldNode
    self.head = newNode
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
    
    return deleteValue
  }
}
