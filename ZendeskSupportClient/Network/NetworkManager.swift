//
//  NetworkManager.swift
//  ZendeskSupportDemo
//
//  Created by Meera on 20/11/18.
//

import Foundation

//This defines the type of data we expect as response from server
public enum DataType {
    case Json
    case Data
}

//This defines the type of HTTP method used to perform the request
public enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum RequestParams {
    case body(_ : [String: Any]?)
    case url(_ : [String: Any]?)
}

//This is the Request protocol you may implement other classes can conform
public protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams { get }
    var headers: [String: Any]? { get }
    var dataType: DataType { get }
}

//Worker is the outer level of our Network Layer
protocol Worker {
    associatedtype Output
    
    //work request to be executed in dispatcher
    var request: Request { get }
    
    //execute work request in dispatcher
    func doWork(in dispatcher: Dispatcher, completion: @escaping (Output) -> ())
}
