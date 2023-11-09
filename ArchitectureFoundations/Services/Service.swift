//
//  Service.swift
//  ArchitectureFoundations
//
//  Created by Exequiel Banga on 16/10/2023.
//

import Foundation

class Service{
  static func baseURL()->URL{URL(string: "https://api.escuelajs.co/api/v1/")!}
  var headers: [String:String]?
  
  init() {
    self.headers = nil
  }
  
  func get(urlString:String, parameters:[String:CustomStringConvertible]? = nil, usingBaseURL:Bool = true)async throws -> (Data, URLResponse){
    let url = try fullUrl(path: urlString, usingBaseURL: usingBaseURL)

    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
    if let parameters = parameters{
      var queryItems = [URLQueryItem]()
      for (name, value) in parameters {
        queryItems.append(URLQueryItem(name: name, value: String(describing: value)))
      }
      urlComponents.queryItems = queryItems
      urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
    }
    
    var request = URLRequest(url: urlComponents.url!)
    request.httpMethod = "GET"

    addHeaders(to: &request)

    return try await URLSession.shared.data(for: request)
  }
  
  func post(urlString:String, body: any Encodable, usingBaseURL: Bool = true)async throws -> (Data, URLResponse){
    try await self.upload(httpMethod: "POST", urlString: urlString, body: body, usingBaseURL: usingBaseURL)
  }

  func put(urlString:String, body: any Encodable, usingBaseURL: Bool = true)async throws -> (Data, URLResponse){
    try await self.upload(httpMethod: "PUT", urlString: urlString, body: body, usingBaseURL: usingBaseURL)
  }
  
  func delete(urlString:String, usingBaseURL:Bool = true)async throws -> (Data, URLResponse){
    let url = try fullUrl(path: urlString, usingBaseURL: usingBaseURL)

    var request = URLRequest(url:url)
    request.httpMethod = "DELETE"

    addHeaders(to: &request)
    return try await URLSession.shared.data(for: request)
  }
  
  private func fullUrl(path: String, usingBaseURL:Bool = true) throws -> URL{
    guard let url = URL(string: path, relativeTo: usingBaseURL ? Self.baseURL() : nil) else{
      throw NetworkError.invalidURL
    }
    return url
  }
  
  private func addHeaders(to urlRequest: inout URLRequest){
    if let headers = headers{
      for (name, value) in headers {
        urlRequest.setValue(value, forHTTPHeaderField: name)
      }
    }
  }
  
  private func upload(httpMethod: String, urlString: String, body: any Encodable, usingBaseURL: Bool) async throws -> (Data, URLResponse){
    let url = try self.fullUrl(path: urlString)
                
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    addHeaders(to: &request)
    
    let encodedBody = try JSONEncoder().encode(body)
    
    return try await URLSession.shared.upload(for: request, from: encodedBody)
  }

  func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
    guard let httpResponse = response.response as? HTTPURLResponse else {
      return response.data
    }
    
    switch httpResponse.statusCode {
    case 200..<300:
      return response.data
    case 400:
      throw NetworkError.badRequest
    case 401:
      throw NetworkError.unauthorized
    case 403:
      throw NetworkError.forbidden
    case 404:
      throw NetworkError.notFound
    case 413:
      throw NetworkError.requestEntityTooLarge
    case 422:
      throw NetworkError.unprocessableEntity
    default:
      throw NetworkError.http(httpResponse: httpResponse, data: response.data)
    }
  }
}

public enum NetworkError: Error, LocalizedError {
  
  case invalidURL
  
  case missingRequiredFields(String)
  
  case invalidParameters(operation: String, parameters: [Any])
  
  case badRequest
  
  case unauthorized
  
  case forbidden
  
  case notFound
  
  case requestEntityTooLarge
  
  case unprocessableEntity
  
  case http(httpResponse: HTTPURLResponse, data: Data)
  
  case invalidResponse(Data)
  
  case deleteOperationFailed(String)
  
  case network(URLError)
  
  case unknown(Error?)
  
}
