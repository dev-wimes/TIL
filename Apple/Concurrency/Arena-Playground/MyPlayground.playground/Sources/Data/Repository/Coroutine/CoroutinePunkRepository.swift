import Foundation
import _Concurrency

public protocol CoroutinePunkRepository {
  func fetchBeers(page: Int, perPage: Int) async throws -> [Beer]
}

public final class CoroutinePunkRepositoryImpl: CoroutineBaseRepository, CoroutinePunkRepository {
  public func fetchBeers(page: Int, perPage: Int) async throws -> [Beer] {
    let query = BeersQ(page: page, perPage: perPage)
    
    let api = PunkAPI.beers(q: query)
    return try await self.execute(api: api)
  }
}
