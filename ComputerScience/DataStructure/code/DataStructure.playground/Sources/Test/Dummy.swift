//import Foundation
//
//print("------------------------Jagged Array------------------------")
//let jaggedArray: JaggedArray<Int> = .init()
//jaggedArray.append(1)
//jaggedArray.append(2)
//print(jaggedArray.removeLast())
//jaggedArray.removeAt(0)
//jaggedArray[0] = 1
//print(jaggedArray.values)
//
//JaggedArrayTest.defaultTestSuite.run()
//
//print("------------------------Single Linked List------------------------")
//let singleLinkedList: SingleLinkedList<Int> = .init()
//singleLinkedList.create(0)
//singleLinkedList.create(1)
//print(singleLinkedList.values)
//// @@todo index param 넣어주자
//singleLinkedList.delete(at: 0)
//singleLinkedList.create(2)
//print(singleLinkedList.values)
//singleLinkedList.removeLast()
//print(singleLinkedList.values)
//singleLinkedList.create(2)
//print(singleLinkedList.values)
//singleLinkedList.insert(index: 0, value: 0)
//singleLinkedList.insert(index: -1, value: 0)
//print(singleLinkedList.values)
//singleLinkedList.insert(index: 1, value: -1)
//print(singleLinkedList.values)
//singleLinkedList.create(0)
//singleLinkedList.create(0)
//print(singleLinkedList.values)
//print(singleLinkedList.search(0))
//
//print("------------------------Double Linked List------------------------")
//let doubleLinkedList: DoubleLinkedList<Int> = .init()
//doubleLinkedList.create(0)
//doubleLinkedList.create(1)
//print(doubleLinkedList.values) // 0, 1
//doubleLinkedList.delete(at: 0)
//doubleLinkedList.create(2)
//print(doubleLinkedList.values) // 1, 2
//doubleLinkedList.create(3) // 1, 2, 3
//doubleLinkedList.create(4) // 1, 2, 3, 4
//doubleLinkedList.create(5) // 1, 2, 3, 4, 5
//print(doubleLinkedList.values)
//doubleLinkedList.delete(at: 2) // 1, 2, 4, 5
//print(doubleLinkedList.values) // MARK: 1, 2, 4, 5
//doubleLinkedList.removeLast() // 1, 2, 4
//print(doubleLinkedList.values) // MARK: 1, 2, 4
//doubleLinkedList.create(2) // 1, 2, 4, 2
//print(doubleLinkedList.values) // MARK: 1, 2, 4, 2
//doubleLinkedList.insert(index: 0, value: 0)
//print(doubleLinkedList.values)
//doubleLinkedList.insert(index: 1, value: -1)
//print(doubleLinkedList.values)
//doubleLinkedList.insert(index: 2, value: -2)
//print(doubleLinkedList.values)
//doubleLinkedList.create(0)
//doubleLinkedList.create(0)
//print(doubleLinkedList.values)
//print(doubleLinkedList.search(0, increase: true))
//print(doubleLinkedList.search(0, increase: false))
//// index 방어로직 테스트
//doubleLinkedList.insert(index: 50, value: -1)
//doubleLinkedList.delete(at: 50)
//print(doubleLinkedList.values)
//
//print("------------------------Stack(Using SingleLinkedList------------------------")
//let stack: Stack<Int> = .init()
//stack.push(value: 0)
//print(stack.values)
//print(stack.pop())
//print(stack.values)
//stack.push(value: 0)
//print(stack.values)
//stack.push(value: 1)
//print(stack.values)
//stack.push(value: 2)
//print(stack.values)
//print(stack.pop())
//print(stack.values)
//
//print("------------------------Queue(Using SingleLinkedList------------------------")
//let queue: Queue<Int> = .init()
//queue.push(value: 0)
//print(queue.values)
//print(queue.pop())
//print(queue.values)
//queue.push(value: 0)
//print(queue.values)
//queue.push(value: 1)
//print(queue.values)
//queue.push(value: 2)
//print(queue.values)
//print(queue.pop())
//print(queue.values)
//print(queue.pop())
//print(queue.pop())
//print(queue.pop())
//print(queue.values)
//
//// MARK: - Circular Queue
//print("------------------------Circular Queue(using SingleLinkedList------------------------")
