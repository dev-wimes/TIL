import Foundation

import _Concurrency

public class CoroutineBaseRepository {
  private let session = URLSession.shared
  
  public init() { }
  
  func execute<T: Decodable>(api: BaseTargetType) async throws -> T{
    let data: Data
    let response: URLResponse
    do {
      (data, response) = try await self.session.data(for: api.request)
    } catch {
      throw NetworkError.requestFail
    }
    
    
    guard let httpResponse = response as? HTTPURLResponse,
          (httpResponse.statusCode >= 200 && httpResponse.statusCode < 300)
    else {
      throw NetworkError.invalidHttpStatusCode(responseBody: data.dictionary)
    }
    
    let decodedData: T
    do {
      decodedData = try JSONDecoder().decode(T.self, from: data)
    }catch {
      throw NetworkError.dataConvertFail
    }
    
    return decodedData
  }
}
