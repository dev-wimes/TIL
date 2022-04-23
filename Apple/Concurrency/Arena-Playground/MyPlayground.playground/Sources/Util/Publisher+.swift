import Foundation

import Combine

extension Publisher {
  public func flatMapLatest<T: Publisher>(_ transform: @escaping (Self.Output) -> T) -> AnyPublisher<T.Output, T.Failure> where T.Failure == Self.Failure {
    return map(transform).switchToLatest().eraseToAnyPublisher()
  }
  
  public static func empty() -> AnyPublisher<Output, Failure> {
    return Empty().eraseToAnyPublisher()
  }
  
  public static func just(_ output: Output) -> AnyPublisher<Output, Never> {
    return Just(output)
      .eraseToAnyPublisher()
  }
  
  public func mapToResult() -> AnyPublisher<Result<Output, Failure>, Never> {
    map(Result.success)
      .catch { Just(.failure($0)) }
      .eraseToAnyPublisher()
  }
}
