//
//  WeekDayView.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/18.
//

import SwiftUI

struct WeekDayView: View {
    let num: Int
    let today = weekOfDay(of: Date())
    var body: some View {
        switch num {
        case 0:
            if num == today {
                Text("Sun")
                    .bold()
                    .foregroundColor(.red)
            } else {
                Text("Sun")
                    .foregroundColor(.red)
            }
        case 1:
            if num == today {
                Text("Mon")
                    .bold()
            } else {
                Text("Mon")
            }
        case 2:
            if num == today {
                Text("Tue")
                    .bold()
            } else {
                Text("Tue")
            }
        case 3:
            if num == today {
                Text("Wed")
                    .bold()
            } else {
                Text("Wed")
            }
        case 4:
            if num == today {
                Text("Thu")
                    .bold()
            } else {
                Text("Thu")
            }
        case 5:
            if num == today {
                Text("Fri")
                    .bold()
            } else {
                Text("Fri")
            }
        case 6:
            if num == today {
                Text("Sat")
                    .bold()
                    .foregroundColor(.red)
            } else {
                Text("Sat")
                    .foregroundColor(.red)
            }
        default:
            Text("error")
        }
    }
}

struct WeekDayView_Previews: PreviewProvider {
    static var previews: some View {
        WeekDayView(num: 5)
    }
}
