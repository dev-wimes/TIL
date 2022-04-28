print("Hello World!")

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

// MARK: - Single Linked List
class Node<T> {
  var value: T
  var next: Node?
  var prev: Node?
  
  init(value: T, next: Node? = nil) {
    self.value = value
    self.next = next
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
  func delete(_ index: Int) -> T?{
    if self.head == nil {
      return nil
    }
    
    if index == 0 {
      let deletingValue = self.head?.value
      self.head = self.head?.next
      self.head?.next = nil
      
      return deletingValue
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

// MARK: - Double Linked List

// MARK: - Queue

// MARK: - Stack

// MARK: - Circular Queue
