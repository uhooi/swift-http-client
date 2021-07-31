import Foundation

/// HTTP client.
public final class HTTPClient {
    
    // MARK: Stored Instance Properties
    
    private let baseURLString: String
    
    // MARK: Initializers
    
    /// Initializer.
    /// - Parameter baseURLString: base URL string.
    public init(baseURLString: String) {
        self.baseURLString = baseURLString
    }
    
    // MARK: Other Public Methods
    
    /// Send an HTTP request.
    ///
    /// No response.
    ///
    /// - Parameters:
    ///   - requestContents: Request contents.
    ///   - completion: Completion handler.
    public func request<T: Request>(_ requestContents: T, completion: @escaping (Error?) -> Void) {
        let request: URLRequest
        do {
            request = try createRequest(requestContents)
        } catch let error {
            completion(error)
            return
        }
        
        self.request(request, completion: completion)
    }
    
    /// Send an HTTP request.
    ///
    /// Response.
    ///
    /// - Parameters:
    ///   - requestContents: Request contents.
    ///   - completion: Completion handler.
    public func request<T: Request>(_ requestContents: T, completion: @escaping (Result<T.ResponseBody, Error>) -> Void) {
        let request: URLRequest
        do {
            request = try createRequest(requestContents)
        } catch let error {
            completion(.failure(error))
            return
        }
        
        self.request(requestContents, request: request, completion: completion)
    }
    
    /// Send an HTTP request.
    ///
    /// No response.
    ///
    /// - Parameters:
    ///   - requestContents: Request contents.
    ///   - requestBody: Request body.
    ///   - completion: Completion handler.
    public func request<T: Request, U: Encodable>(_ requestContents: T, requestBody: U, completion: @escaping (Error?) -> Void) {
        var request: URLRequest
        do {
            request = try createRequest(requestContents)
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch let error {
            completion(error)
            return
        }
        
        self.request(request, completion: completion)
    }
    
    /// Send an HTTP request.
    ///
    /// Response.
    ///
    /// - Parameters:
    ///   - requestContents: Request contents.
    ///   - requestBody: Request body.
    ///   - completion: Completion handler.
    public func request<T: Request, U: Encodable>(_ requestContents: T, requestBody: U, completion: @escaping (Result<T.ResponseBody, Error>) -> Void) {
        var request: URLRequest
        do {
            request = try createRequest(requestContents)
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch let error {
            completion(.failure(error))
            return
        }
        
        self.request(requestContents, request: request, completion: completion)
    }
    
    // MARK: Other Private Methods
    
    private func createRequest<T: Request>(_ requestContents: T) throws -> URLRequest {
        guard let url = URL(string: baseURLString + requestContents.path),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: url.baseURL != nil)
        else {
            throw RequestError.invalidUrl
        }
        
        if let queryItems = requestContents.queryItems {
            components.queryItems = queryItems + (components.queryItems ?? [])
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = requestContents.httpMethod.rawValue
        if let httpHeaders = requestContents.httpHeaders {
            for (field, value) in httpHeaders {
                request.addValue(value, forHTTPHeaderField: field.rawValue)
            }
        }
        
        return request
    }
    
    private func request(_ request: URLRequest, completion: @escaping (Error?) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            if let requestError = self.validateResponse(response) {
                completion(requestError)
                return
            }
            completion(nil)
            return
        }.resume()
    }
    
    private func request<T: Request>(_ requestContents: T, request: URLRequest, completion: @escaping (Result<T.ResponseBody, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let requestError = self.validateResponse(response) {
                completion(.failure(requestError))
                return
            }
            guard let data = data else {
                completion(.failure(RequestError.invalidData))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let responseBody = try jsonDecoder.decode(T.ResponseBody.self, from: data)
                completion(.success(responseBody))
                return
            } catch let error {
                completion(.failure(error))
                return
            }
        }.resume()
    }
    
    private func validateResponse( _ response: URLResponse?) -> RequestError? {
        guard let response = response as? HTTPURLResponse else {
            return .invalidResponse
        }
        if let requestError = self.validateStatusCode(response.statusCode) {
            return requestError
        }
        return nil
    }
    
    private func validateStatusCode(_ statusCode: Int) -> RequestError? {
        switch statusCode {
        case 100..<200: // Informational
            return nil
        case 200..<300: // Success
            return nil
        case 300..<400:
            return .redirection(statusCode)
        case 400..<500:
            return .clientError(statusCode)
        case 500..<600:
            return .serverError(statusCode)
        default:
            return .invalidStatusCode(statusCode)
        }
    }
}
