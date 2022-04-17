import Foundation

import RxSwift

public class RxBaseRepository {
  
  private let session = URLSession.shared
  
  public init() { }
  
  func execute<T: Decodable>(api: BaseTargetType) -> Observable<T> {
    return Observable<T>.create { observable in
      let task = self.session.dataTask(with: api.request) { data, response, error in
        if let error = error {
          observable.onError(error)
          observable.onCompleted()
        }
        
        if let response = response as? HTTPURLResponse {
          if !(response.statusCode >= 200 && response.statusCode < 300) {
            observable.onError(NetworkError.invalidHttpStatusCode(responseBody: data?.dictionary ?? [:]))
            observable.onCompleted()
          }
        }
        
        guard let data = data,
              let json = try? JSONDecoder().decode(T.self, from: data)
        else {
          observable.onError(NetworkError.dataConvertFail)
          observable.onCompleted()
          return
        }

        observable.onNext(json)
        observable.onCompleted()
      }
      
      task.resume()
      
      return Disposables.create { task.cancel() }
    }
  }
  
  // depreacated
  func execute_sinle<T: Decodable>(api: BaseTargetType) -> Single<T> {
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
      
      task.resume()
      
      return Disposables.create { task.cancel() }
    }
  }
}
