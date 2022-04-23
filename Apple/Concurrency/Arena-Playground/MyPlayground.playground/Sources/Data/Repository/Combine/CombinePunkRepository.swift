import Combine

public protocol CombinePunkRepository {
  func fetchBeers(page: Int, perPage: Int) -> AnyPublisher<[Beer], NetworkError>
}

public final class CombinePunkRepositoryImpl: CombineBaseRepository, CombinePunkRepository {
  public func fetchBeers(page: Int, perPage: Int) -> AnyPublisher<[Beer], NetworkError> {
    let query = BeersQ(page: page, perPage: perPage)
    
    let api = PunkAPI.beers(q: query)
    return self.execute(api: api)
  }
}
