//
//  ZDTicketModel.swift
//  ZendeskSupportDemo
//
//  Created by Meera on 19/11/18.
//

import Foundation

class Ticket {
    
    let id : Int
    let subject: String
    let status: String
    let description: String
    
    init(id: Int, subject: String, status: String, desc: String) {
        self.id = id
        self.subject = subject
        self.status = status
        self.description = desc
    }
    
    class func allTickets(data: [[String:Any]]) ->  [Ticket] {
        var tickets = [Ticket]()
        for ticket in data {
            if let id = ticket["id"] as? Int, let subject = ticket["subject"] as? String, let status = ticket["status"] as? String, let description = ticket["description"] as? String {
                tickets.append(Ticket.init(id: id, subject: subject, status: status, desc: description))
            }
        }
        return tickets
    }
}
