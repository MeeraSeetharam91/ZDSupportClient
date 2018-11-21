//
//  TicketTests.swift
//  ZendeskSupportClientTests
//
//  Created by Meera on 21/11/18.
//  Copyright © 2018 Meera. All rights reserved.
//

import XCTest
@testable import ZendeskSupportClient

class TicketTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testRequiredTicketInitializers() {
        //Valid Data
        let dataSet1 = [["id":103, "subject":"Ticket : 99", "description":"This is a test ticket", "status": "new"],
                        ["id":102, "subject":"Ticket : 98", "description":"This is a test ticket", "status": "open"],
                        ["id":101, "subject":"Ticket : 97", "description":"This is a test ticket", "status": "pending"]]
        XCTAssertTrue( Ticket.allTickets(data: dataSet1).count > 0)

        //Data type of value change
        let dataSet2 = [["id":"105", "subject":"Ticket : 99", "description":"This is a test ticket", "status": "new"]]
        XCTAssertFalse( !Ticket.allTickets(data: dataSet2).isEmpty)
        
        //Required data missing
        let dataSet3 = [["subject":"Ticket : 99", "description":"This is a test ticket", "status": "new"]]
        XCTAssertFalse( !Ticket.allTickets(data: dataSet3).isEmpty)

        let dataSet4 = [["id":103, "description":"This is a test ticket", "status": "new"]]
        XCTAssertFalse( !Ticket.allTickets(data: dataSet4).isEmpty)

        let dataSet5 = [["id":105, "subject":"Ticket : 99", "status": "new"]]
        XCTAssertFalse( !Ticket.allTickets(data: dataSet5).isEmpty)

        let dataSet6 = [["id":105, "subject":"Ticket : 99", "description":"This is a test ticket"]]
        XCTAssertFalse( !Ticket.allTickets(data: dataSet6).isEmpty)

    }
}
