import Foundation

import _Concurrency

final class CoroutineBaseRepository {
  private let session = URLSession.shared
  
  func execute<T: Decodable>(api: BaseTargetType) async throws -> T{
    let (data, response) = try await self.session.data(for: api.request)
    
    guard let httpResponse = response as? HTTPURLResponse,
          !(httpResponse.statusCode >= 200 && httpResponse.statusCode < 300)
    else {
      throw NetworkError.invalidHttpStatusCode(responseBody: data.dictionary)
    }
    
    return try JSONDecoder().decode(T.self, from: data)
  }
}
