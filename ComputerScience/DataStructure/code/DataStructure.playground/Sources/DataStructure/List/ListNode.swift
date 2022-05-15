import Foundation

public class ListNode<T> {
  public var value: T?
  public var next: ListNode?
  public var prev: ListNode?
  
  public init(value: T?, next: ListNode? = nil, prev: ListNode? = nil) {
    self.value = value
    self.next = next
    self.prev = prev
  }
}
