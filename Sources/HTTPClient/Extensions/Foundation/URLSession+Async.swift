import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@available(iOS, introduced: 13.0, deprecated: 15.0, message: "Use the built-in API instead")
extension URLSession {

    func data(from request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            self.dataTask(with: request) { data, response, error in
                if let error = error {
                    return continuation.resume(throwing: error)
                }
                guard let data = data, let response = response else {
                    return continuation.resume(throwing: URLError(.badServerResponse))
                }
                continuation.resume(returning: (data, response))
            }.resume()
        }
    }

}

