//
//  ZDSupportWorker.swift
//  ZendeskSupportClient
//
//  Created by Meera on 20/11/18.
//  Copyright © 2018 Meera. All rights reserved.
//

import Foundation

class ZDSupporWorker: Worker {
    
    let viewId: String
    
    init(viewId: String) {
        self.viewId = viewId
    }

    var request: Request {
        return APIRequest.tickets(viewId: viewId)
    }
    
    func doWork(in dispatcher: Dispatcher, completion: @escaping (Any?) -> ()) {
        do {
            try dispatcher.execute(request: request) { (response) in
                completion(response)
            }
        } catch(let error) {
            print(error)
        }
    }
}
