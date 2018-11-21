//
//  ZDSupportInteractor.swift
//  ZendeskSupportDemo
//
//  Created by Meera on 19/11/18.
//

import Foundation

/**
 ZDSupportInteractor contains api call to fetch ticket list 
 */
class ZDSupportInteractor {
    
    let viewId: String
    
    init(viewId: String) {
        self.viewId = viewId
    }
    
    func tickets(completion: @escaping ([Ticket]) -> ()) {
        let worker = ZDSupporWorker.init(viewId: viewId)
        var ticketModelList = [Ticket]()
        worker.doWork(in: NetworkDispatcher.init(environment: Environment.init("Test", host: "https://mxtechtest.zendesk.com")), completion: {data in
            
            if let responseDict = data as? [String:Any] {
                if let ticketList = responseDict["tickets"] as? [[String:Any]]{
                    ticketModelList = Ticket.allTickets(data: ticketList)
                    completion(ticketModelList)
                }
            }
        })
        completion(ticketModelList)
    }
}
