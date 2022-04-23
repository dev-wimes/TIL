import Foundation

import RxSwift

public protocol RxPunkRepository {
  func fetchBeers(page: Int, perPage: Int) -> Observable<[Beer]>
}

public final class RxPunkRepositoryImpl: RxBaseRepository, RxPunkRepository {
  public func fetchBeers(page: Int, perPage: Int) -> Observable<[Beer]> {
    let query = BeersQ(page: page, perPage: perPage)
    
    let api = PunkAPI.beers(q: query)
    return self.execute(api: api)
  }
}
