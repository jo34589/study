//
//  CalenderView.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/18.
//

import SwiftUI

struct CalenderView: View {
    
    @EnvironmentObject var eventHandler: EventHandler
    
    var body: some View {
        
        let date = eventHandler.date
        let year = Int(toYearString(date:date))!
        let month = Int(toMonthString(date: date))!
        let firstWeekOfDay = firstWeekOfDay(of: date)
        
        GeometryReader { geometry in
            let rowHeight = geometry.size.height/5
            let rowWidth = geometry.size.width
            VStack(spacing: 0) {
                ForEach(0 ..< 5) { rowIndex in
                    //calenderRow goes here
                    CalenderRow(
                        firstWeekOfDay: firstWeekOfDay,
                        month: month,
                        year: year,
                        rowIndex: rowIndex)
                        .environmentObject(eventHandler)
                        .frame(width: rowWidth, height: rowHeight, alignment: .center)
                        .listRowInsets(.init())
                    Divider()
                }
            }
        }
    }
}

struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        CalenderView()
            .environmentObject(EventHandler(date: Date(), events:[dummyEvent1]))
    }
}
