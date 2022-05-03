print("Hello World!")

print("------------------------Jagged Array------------------------")
//MARK: - Jagged Array
class JaggedArray<T: Hashable> {
  private let capacityOffset: Int = 5
  private var capacity: Int = 5
  private var realValues: [T?]
  
  var count: Int = 0
  var values: [T] {
    get {
      return self.realValues.compactMap { $0 }
    }
  }
  
  init() {
    self.realValues = [T?](repeating: nil, count: self.capacity)
  }
  
  func append(_ value: T) {
    if self.capacity > self.count {
      self.realValues[self.count] = value
      self.count += 1
    } else {
      self.capacity += self.capacityOffset
      self.realValues[self.count] = value
      self.count += 1
    }
  }
  
  func removeLast() -> T? {
    if self.count > 0 {
      let lastValue = self.realValues[self.count - 1]
      self.realValues[self.count - 1] = nil
      return lastValue
    }
    
    return nil
  }
  
  func removeAt(_ index: Int) -> T? {
    if self.count - 1 < index {
      print("index out of bounds")
      return nil
    }
    let removedValue = self.realValues[index]
    
    self.realValues[index] = nil
    for i in index..<self.count {
      self.realValues[i] = self.realValues[i + 1]
    }
    self.realValues[self.count - 1] = nil
    self.count -= 1
    
    return removedValue
  }
  
  func isEmpty() -> Bool {
    if self.count == 0 { return true }
    else { return false }
  }
  
  subscript(_ index: Int) -> T? {
    get {
      if self.count - 1 < index {
        return nil
      }
      guard let returnValue = self.realValues[index],
            self.count - 1 < index
      else { return nil }
      return returnValue
    }
    
    set {
      if self.count - 1 < index {
        print("index out of bounds")
        return
      }
      self.realValues[index] = newValue
    }
  }
}

let jaggedArray: JaggedArray<Int> = .init()
jaggedArray.append(1)
jaggedArray.append(2)
print(jaggedArray.removeLast())
jaggedArray.removeAt(0)
jaggedArray[0] = 1
print(jaggedArray.values)

print("------------------------Single Linked List------------------------")
// MARK: - Single Linked List
class Node<T> {
  var value: T?
  var next: Node?
  var prev: Node?
  
  init(value: T?, next: Node? = nil, prev: Node? = nil) {
    self.value = value
    self.next = next
    self.prev = prev
  }
}

class SingleLinkedList<T: Equatable> {
  private var head: Node<T>? = nil
  var values: [T?] {
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
  
  // 생성
  func create(_ value: T) {
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
  func delete(_ index: Int) -> T? {
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
  
  func removeLast() -> T? {
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
  func insert(index: Int, value: T) {
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
  func search(_ value: T) -> [Int] {
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

let singleLinkedList: SingleLinkedList<Int> = .init()
singleLinkedList.create(0)
singleLinkedList.create(1)
print(singleLinkedList.values)
singleLinkedList.delete(0)
singleLinkedList.create(2)
print(singleLinkedList.values)
singleLinkedList.removeLast()
print(singleLinkedList.values)
singleLinkedList.create(2)
print(singleLinkedList.values)
singleLinkedList.insert(index: 0, value: 0)
print(singleLinkedList.values)
singleLinkedList.insert(index: 1, value: -1)
print(singleLinkedList.values)
singleLinkedList.create(0)
singleLinkedList.create(0)
print(singleLinkedList.values)
print(singleLinkedList.search(0))

print("------------------------Double Linked List------------------------")
// MARK: - Double Linked List
class DoubleLinkedList<T: Equatable> {
  private var head: Node<T>? = Node(value: nil, next: nil, prev: nil)
  private var tail: Node<T>? = Node(value: nil, next: nil, prev: nil)
  
  var values: [T?] {
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
  
  init() {
    self.head?.next = self.tail
    self.tail?.prev = self.head
  }
  
  private func isAvailableIndex(_ index: Int) -> Bool {
    var node = self.head?.next
    for _ in 0 ..< index - 1 {
      if node?.next?.next == nil { return false }
      node = node?.next
    }
    
    return true
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
  func insert(index: Int, value: T) {
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
  func create(_ value: T) {
    let lastNode = self.tail?.prev
    let newNode = Node(value: value, next: self.tail, prev: lastNode)
    lastNode?.next = newNode
    self.tail?.prev = newNode
  }
  
  // 삭제
  func delete(_ index: Int) -> T? {
    guard let purposeNode = self.increaseLoop(destination: index) else { return nil }
    
    let prevNode = purposeNode.prev
    let nextNode = purposeNode.next
    
    prevNode?.next = nextNode
    nextNode?.prev = prevNode
    purposeNode.next = nil
    purposeNode.prev = nil
    
    return purposeNode.value
  }
  
  func removeLast() -> T? {
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
  func search(_ value: T, increase: Bool) -> [Int] {
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

let doubleLinkedList: DoubleLinkedList<Int> = .init()
doubleLinkedList.create(0)
doubleLinkedList.create(1)
print(doubleLinkedList.values) // 0, 1
doubleLinkedList.delete(0)
doubleLinkedList.create(2)
print(doubleLinkedList.values) // 1, 2
doubleLinkedList.create(3) // 1, 2, 3
doubleLinkedList.create(4) // 1, 2, 3, 4
doubleLinkedList.create(5) // 1, 2, 3, 4, 5
doubleLinkedList.delete(2) // 1, 2, 4, 5
print(doubleLinkedList.values) // MARK: 1, 2, 4, 5
doubleLinkedList.removeLast() // 1, 2, 4
print(doubleLinkedList.values) // MARK: 1, 2, 4
doubleLinkedList.create(2) // 1, 2, 4, 2
print(doubleLinkedList.values) // MARK: 1, 2, 4, 2
doubleLinkedList.insert(index: 0, value: 0)
print(doubleLinkedList.values)
doubleLinkedList.insert(index: 1, value: -1)
print(doubleLinkedList.values)
doubleLinkedList.insert(index: 2, value: -2)
print(doubleLinkedList.values)
doubleLinkedList.create(0)
doubleLinkedList.create(0)
print(doubleLinkedList.values)
print(doubleLinkedList.search(0, increase: true))
print(doubleLinkedList.search(0, increase: false))
// index 방어로직 테스트
doubleLinkedList.insert(index: 50, value: -1)
doubleLinkedList.delete(50)
print(doubleLinkedList.values)

print("------------------------Stack(Using SingleLinkedList------------------------")
// MARK: - Stack
class Stack<T: Equatable> {
  
  private var head: Node<T>? = nil
  
  var values: [T?] {
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
  
  private func isEmpty() -> Bool {
    return self.head == nil
  }
  
  func push(value: T) {
    let newNode = Node(value: value)
    
    if self.isEmpty() {
      self.head = newNode
      return
    }
    
    let oldNode = self.head
    newNode.next = oldNode
    self.head = newNode
  }
  
  func pop() -> T? {
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

let stack: Stack<Int> = .init()
stack.push(value: 0)
print(stack.values)
print(stack.pop())
print(stack.values)
stack.push(value: 0)
print(stack.values)
stack.push(value: 1)
print(stack.values)
stack.push(value: 2)
print(stack.values)
print(stack.pop())
print(stack.values)

print("------------------------Queue(Using SingleLinkedList------------------------")
// MARK: - Queue
class Queue<T: Equatable> {
  
  private var head: Node<T>? = nil
  private var tail: Node<T>? = nil
  
  var values: [T?] {
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
  
  private func isEmpty() -> Bool {
    return self.head == nil
  }
  
  func push(value: T) {
    let newNode = Node(value: value)
    
    if self.isEmpty() {
      self.head = newNode
      self.tail = newNode
      return
    }
    
    let oldNode = self.tail
    oldNode?.next = newNode
    self.tail = newNode
  }
  
  func pop() -> T? {
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
let queue: Stack<Int> = .init()
queue.push(value: 0)
print(queue.values)
print(queue.pop())
print(queue.values)
queue.push(value: 0)
print(queue.values)
queue.push(value: 1)
print(queue.values)
queue.push(value: 2)
print(queue.values)
print(queue.pop())
print(queue.values)

// MARK: - Circular Queue
print("------------------------Circular Queue(using SingleLinkedList------------------------")
