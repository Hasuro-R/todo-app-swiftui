import Foundation

enum ApiError: Error {
    case invalidUrl
    case invalidResponse
    case serverError
    case decodingError
    case unknownError
}

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

public class ApiClient {
    public let urlString: String
    public let method: HttpMethod
    
    public init (urlString: String, method: HttpMethod) {
        self.urlString = urlString
        self.method = method
    }
    
    private func createRequest<T: Encodable>(body: T?) -> URLRequest? {
        guard let url = URL(string: "http:/localhost:8080/\(urlString)") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body = body {
            request.httpBody = try? JSONEncoder().encode(body)
            request.setValue("application/body", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
    
    public func fetchData<T: Codable, U: Encodable>(responseType: T.Type, requestBody: U? = nil) async throws -> T {
        guard let request = createRequest(body: requestBody) else {
            throw ApiError.invalidUrl
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ApiError.serverError
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
