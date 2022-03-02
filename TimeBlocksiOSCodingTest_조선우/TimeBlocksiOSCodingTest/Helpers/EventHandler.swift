//
//  EventHandler.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/19.
//

import Foundation

class EventHandler: ObservableObject {
    
    var lastEventId: Int
    var tappedDate: Date?
    var date: Date
    //shared data
    @Published var events: [Event]
    @Published var isAdding: Bool = false
    
    init(date: Date, events: [Event]) {
        self.date = date
        self.events = events
        self.lastEventId = events.count
    }
    
    func cellTapped(year: Int, month: Int, day: Int, rowIndex: Int) {
        let tappedDate = getDate(year: year, month: month, day: day, rowIndex: rowIndex)
        self.tappedDate = tappedDate
        self.isAdding = true
    }
    
    func addNewEvent(startDate: Date, endDate: Date, eventStr: String) {
        let newId = self.lastEventId + 1
        let color = newId%4
        
        var newEvent = Event(id: newId, startDate: startDate, endDate: endDate, eventStr: eventStr, color: color)
        self.events.forEach { event in
            if event.endDate >= newEvent.startDate {
                if event.startDate <= newEvent.endDate {
                    newEvent.level += 1
                }
            }
        }
        self.events.append(newEvent)
        self.events.sort(by: {$0.id < $1.id})
    }

    func eventsOfDay(thisDay: Date) -> [Event] {
        guard !events.isEmpty else {
            return []
        }
        var rtn: [Event] = []
        events.forEach { event in
            if event.startDate <= thisDay && event.endDate >= thisDay {
                rtn.append(event)
            }
        }
        return rtn
    }
}
