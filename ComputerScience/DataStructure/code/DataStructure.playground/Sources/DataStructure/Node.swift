import Foundation

public class Node<T> {
  public var value: T?
  public var next: Node?
  public var prev: Node?
  
  public init(value: T?, next: Node? = nil, prev: Node? = nil) {
    self.value = value
    self.next = next
    self.prev = prev
  }
}
