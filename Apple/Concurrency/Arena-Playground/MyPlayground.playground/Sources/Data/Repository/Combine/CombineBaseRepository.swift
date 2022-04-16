import Foundation

import Combine

public class CombineBaseRepository {
  private let session = URLSession.shared
  
  public init() { }
  
  func execute<T: Decodable>(api: BaseTargetType) -> AnyPublisher<T, NetworkError> {
    self.session.dataTaskPublisher(for: api.request)
      .tryMap { output -> Data in
        guard let statusCode = (output.response as? HTTPURLResponse)?.statusCode else {
          throw NetworkError.unknown
        }
        
        if statusCode >= 200 && statusCode < 300 {
          return output.data
        } else {
          throw NetworkError.invalidHttpStatusCode(responseBody: output.data.dictionary)
        }
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .mapError { error -> NetworkError in
        switch error {
        case is URLError:
          return .requestFail
        case is DecodingError:
          return .dataConvertFail
        default:
          return error as? NetworkError ?? .unknown
        }
      }
      .eraseToAnyPublisher()
  }
}
