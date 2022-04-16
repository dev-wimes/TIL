import Foundation

import RxSwift

class RxBaseRepository {
  
  private let session = URLSession.shared
  
  func execute<T: Decodable>(api: BaseTargetType) -> Single<T> {
    return Single<T>.create { single in
      let task = self.session.dataTask(with: api.request) { data, response, error in
        if let error = error {
          single(.failure(error))
          return
        }
        
        if let response = response as? HTTPURLResponse {
          if !(response.statusCode >= 200 && response.statusCode < 300) {
            single(.failure(NetworkError.invalidHttpStatusCode(responseBody: data?.dictionary ?? [:])))
            return
          }
        }
        
        guard let data = data,
              let json = try? JSONDecoder().decode(T.self, from: data)
        else {
          single(.failure(NetworkError.dataConvertFail))
          return
        }

        single(.success(json))
      }
      
      return Disposables.create { task.cancel() }
    }
  }
}
