//
//  NetworkDispatcher.swift
//  ZendeskSupportDemo
//
//  Created by Meera on 20/11/18.
//

import Foundation

//The dispatcher is responsible to execute a Request and provide the response
public protocol Dispatcher {
    
    //Configure the dispatcher with an environment
    init(environment: Environment)
    
    //This function executes the request and provide a response
    func execute(request: Request, completion: @escaping (Any?) -> ()) throws
}

public class NetworkDispatcher: Dispatcher {
    
    private var environment: Environment
    private var session: URLSession
    
    public required init(environment: Environment) {
        self.environment = environment
        self.session = URLSession(configuration: .default)
    }
    
    public func execute(request: Request, completion: @escaping (Any?) -> ()) throws {
        let request = try self.prepare(request: request)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let response = Response.data(data!)
            do {
                let dict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                completion(dict)
            } catch {
                completion(response)
            }
            }.resume()
    }
    
    private func prepare(request: Request) throws -> URLRequest {
        
        //1. format the endpoint url using host url and path
        let fullUrl = "\(environment.host)/\(request.path)"
        
        //2. create an api request object with the url and Authorization data
        var apiRequest = URLRequest(url: URL(string: fullUrl)!)
        
        let username = "acooke+techtest@zendesk.com"
        let password = "mobile"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        apiRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        //3. set api request parameters either as body or as query params
        switch request.parameters {
        case .body(let params):
            if let params = params as? [String : String] {
                let body = try? JSONEncoder().encode(params)
                apiRequest.httpBody = body
            } else {
                throw NetworkErrors.badInput
            }
            
        case .url(let params):
            if let params = params as? [String : String] {
                let queryParams = params.map { pair  in
                    return URLQueryItem(name: pair.key, value: pair.value)
                }
                guard var components = URLComponents(string: fullUrl) else {
                    throw NetworkErrors.badInput
                }
                components.queryItems = queryParams
                apiRequest.url = components.url
            } else {
                throw NetworkErrors.badInput
            }
        }
        
        //4. set api request header using common enviorment header parameters and specific request parameters
        environment.headers.forEach { apiRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        request.headers?.forEach { apiRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        
        //5. set api request http method
        apiRequest.httpMethod = request.method.rawValue
        return apiRequest
    }
}
