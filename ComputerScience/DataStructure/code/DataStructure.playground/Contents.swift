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
