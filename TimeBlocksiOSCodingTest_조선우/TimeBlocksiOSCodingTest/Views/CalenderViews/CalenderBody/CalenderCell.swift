//
//  Calendercell.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/18.
//

import SwiftUI

struct CalenderCell: View {
    
    @EnvironmentObject var eventHandler: EventHandler
    var dayParam: dayParam
    
    var body: some View {
        
        let day = dayCalc(columnIndex: dayParam.columnIndex,
                          rowIndex: dayParam.rowIndex,
                          firstDayOfWeek: dayParam.firstWeekOfDay,
                          month: dayParam.month,
                          year: dayParam.year)
        let isThisMonth = isThisMonth(rowIndex: dayParam.rowIndex, day: day)
        let thisDay = getDate(year: dayParam.year, month: dayParam.month, day: day, rowIndex: dayParam.rowIndex)
        
        
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            ZStack(alignment: .top) {
                VStack(alignment: .center, spacing: 0) {
                    if dayParam.columnIndex == 0 || dayParam.columnIndex == 6 {
                        Text("\(day)")
                            .frame(width: width)
                            .foregroundColor(.red)
                    } else {
                        if isThisMonth {
                            Text("\(day)")
                                .frame(width: width)
                        } else {
                            Text("\(day)")
                                .frame(width: width)
                                .foregroundColor(.gray)
                        }
                    }
                    EventView(thisDay: thisDay)
                        .environmentObject(eventHandler)
                }
                
                if isThisMonth {
                    Button() {
                        //action
                        eventHandler.cellTapped(year: dayParam.year, month: dayParam.month, day: day, rowIndex: dayParam.rowIndex)
                    } label: {
                        Text("")
                            .frame(width: width, height: height)
                    }
                }
            }
        }
    }
}

struct CalenderCell_Previews: PreviewProvider {
    static var previews: some View {
        CalenderCell(dayParam: dayParam(columnIndex: 2, rowIndex: 0, firstDayOfWeek: 3, month: 2, year: 2022))
            .frame(width: 60, height: 80)
            .environmentObject(EventHandler(date: Date(), events:[dummyEvent1]))
    }
}
