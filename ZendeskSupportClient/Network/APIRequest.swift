//
//  APIRequest.swift
//  ZendeskSupportDemo
//
//  Created by Meera on 20/11/18.
//

import Foundation

public enum APIRequest {
    case tickets(viewId: String)
}

extension APIRequest: Request {
    
    public var path: String {
        switch self {
        case .tickets(let viewId):
            return "/api/v2/views/\(viewId)/tickets.json"
        }
    }
    
    public var parameters: RequestParams {
        switch self {
        case .tickets(_):
//            let username = "acooke+techtest@zendesk.com"
//            let password = "mobile"
//            let loginString = String(format: "%@:%@", username, password)
//            let loginData = loginString.data(using: String.Encoding.utf8)!
//            let base64LoginString = loginData.base64EncodedString()
//            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

            return.body([:])
        }
    }
    
    public var headers: [String : Any]? {
        
        return [:]
    }
    
    public var method: HTTPMethod {
        switch self {
        case .tickets(_):
            return .get
        }
    }
    
    public var dataType: DataType {
        switch self {
        case .tickets(_):
            return .Json
        }
    }
}
