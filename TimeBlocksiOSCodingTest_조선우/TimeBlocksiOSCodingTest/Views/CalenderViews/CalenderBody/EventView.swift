//
//  EventView.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/20.
//

import SwiftUI

struct EventView: View {
    
    @EnvironmentObject var eventHandler: EventHandler
    let thisDay: Date
    
    var body: some View {
        let events = eventHandler.eventsOfDay(thisDay: thisDay)
        let c = events.count
        VStack(spacing: 0) {
            ForEach( 0 ..< c) { i in
                ZStack(alignment: .leading) {
                    Color(CGColor.CustomColors[events[i].color])
                    if thisDay == events[i].startDate {
                        Text("\(events[i].eventStr)")
                            .font(.system(size: 11))
                    }
                }
                .frame(height: 20)
                .offset(y: CGFloat(25*events[i].level))
            }
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(thisDay: dummyEvent().startdate)
            .environmentObject(EventHandler(date: Date(), events: [dummyEvent1]))
    }
}
