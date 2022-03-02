//
//  EventModel.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/18.
//

import Foundation

struct Event:Identifiable, Equatable, Comparable {
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.id < rhs.id
    }
    
    static func > (lhs: Event, rhs: Event) -> Bool {
        return lhs.id > rhs.id
    }
    
    internal let id: Int
    var startDate: Date
    var endDate: Date
    var eventStr: String
    var color: Int
    var level: Int = 0
    
    init(id: Int, startDate: Date, endDate: Date, eventStr: String, color: Int) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.eventStr = eventStr
        self.color = color
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
}

class dummyEvent {
    let formatter = DateFormatter()
    let startdate:Date
    let enddate:Date
    let eventStr = "test 1"
    
    init() {
        formatter.dateFormat = "yyyy.MM.dd"
        self.startdate = formatter.date(from: "2022.02.05")!
        self.enddate = formatter.date(from: "2022.02.06")!
    }
}
let dummyEvent1 = Event(id: 0, startDate: dummyEvent().startdate, endDate: dummyEvent().enddate, eventStr: "event 0", color: 0)
let blackEvent = Event(id: -1, startDate: Date(), endDate: Date(), eventStr: "", color: 4)

