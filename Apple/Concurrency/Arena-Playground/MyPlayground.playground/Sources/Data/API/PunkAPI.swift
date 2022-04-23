import Foundation

enum PunkAPI {
  case beers(q: BeersQ)
}

extension PunkAPI: BaseTargetType {
  var baseURL: String {
    return "api.punkapi.com"
  }
  
  var path: String {
    switch self {
    case .beers:
      return "/v2/beers"
    }
  }
  
  var queryParameter: [String : Any]? {
    switch self {
    case .beers(q: let q):
      return ["page": q.page, "per_page": q.perPage]
    }
  }
  
  var requestBody: Data? {
    switch self {
    default:
      return nil
    }
  }
  
  var method: Method {
    switch self {
    default:
      return .get
    }
  }
}
