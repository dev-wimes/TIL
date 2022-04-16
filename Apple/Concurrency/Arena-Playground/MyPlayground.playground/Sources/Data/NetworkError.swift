import Foundation

enum NetworkError: Error {
  case requestFail
  case invalidHttpStatusCode(responseBody: [String: Any])
  case dataConvertFail
  case unknown
}

extension NetworkError {
  var description: String {
    switch self {
    case .invalidHttpStatusCode(let responseBody):
      return responseBody.description
    default:
      return self.localizedDescription
    }
  }
}
