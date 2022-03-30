import _Concurrency

class A {
  @TaskLocal static var a = 0
}

Task {
  A.$a
    .withValue(1, operation: {
      print("1Depth", A.a)
      call("1Depth")
      
      A.$a
        .withValue(2) {
          print("2Depth, ", A.a)
          call("2Depth")
        }
    })
}

func call(_ str: String) {
  print(str+#function, A.a)
}

print("outside", A.a)
