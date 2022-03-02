//
//  CalenderRow.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/18.
//

import SwiftUI

struct CalenderRow: View {
    
    @EnvironmentObject var eventHandler: EventHandler
    
    var firstWeekOfDay: Int
    var month: Int
    var year: Int
    var rowIndex: Int
    
    var body: some View {
        GeometryReader { geometry in
            let cellWidth = geometry.size.width/7
            let cellHeight = geometry.size.height
            
            HStack(spacing: 0){
                ForEach(0 ..< 7) { columnIndex in
                    let dayParam = dayParam(columnIndex: columnIndex,
                                            rowIndex: rowIndex,
                                            firstDayOfWeek: firstWeekOfDay,
                                            month: month, year: year)
                    
                    CalenderCell(dayParam: dayParam)
                        .environmentObject(eventHandler)
                        .frame(width: cellWidth, height: cellHeight, alignment: .top)
                }
            }
        }
    }
}

struct CalenderRow_Previews: PreviewProvider {
    static var previews: some View {
        CalenderRow(firstWeekOfDay: firstWeekOfDay(of: Date()),
                    month: Int(toMonthString(date: Date()))!,
                    year: Int(toYearString(date: Date()))!,
                    rowIndex: 0)
            .environmentObject(EventHandler(date: Date(), events:[dummyEvent1]))
    }
}
