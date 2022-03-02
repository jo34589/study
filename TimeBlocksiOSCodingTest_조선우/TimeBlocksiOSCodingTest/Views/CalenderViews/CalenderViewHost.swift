//
//  CalenderView.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/18.
//

import SwiftUI

struct CalenderViewHost: View {
    
    @EnvironmentObject var eventHandler: EventHandler
    
    var body: some View {
        let today = eventHandler.date
        GeometryReader { geometry in
            VStack {
                CalenderHeader(month: toMonthString(date: today), year: toYearString(date: today))
                WeekView()
                    .frame(width: geometry.size.width, height: 30, alignment: .center)
                CalenderView()
                    .environmentObject(eventHandler)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            }
        }
    }
}

struct CalenderViewHost_Previews: PreviewProvider {
    static var previews: some View {
        CalenderViewHost()
            .environmentObject(EventHandler(date: Date(), events: [dummyEvent1]))
    }
}
