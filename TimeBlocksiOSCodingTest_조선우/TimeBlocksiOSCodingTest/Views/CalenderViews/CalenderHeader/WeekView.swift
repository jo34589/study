//
//  WeekView.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/18.
//

import SwiftUI

struct WeekView: View {
    
    var body: some View {
        GeometryReader { geometry in
            let width = (geometry.size.width)/7
            let height: CGFloat = 30
            HStack(spacing: 0) {
                ForEach(0 ..< 7) { i in
                    WeekDayView(num: i)
                        .frame(width: width, height: height, alignment: .center)
                }
            }
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
    }
}
