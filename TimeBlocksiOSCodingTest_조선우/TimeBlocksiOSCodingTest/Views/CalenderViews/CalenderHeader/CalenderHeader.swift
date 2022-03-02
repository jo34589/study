//
//  CalenderHeder.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/18.
//

import SwiftUI

struct CalenderHeader: View {
    
    var month: String
    var year: String
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 15)
            Text(month)
                .frame(width: 70, height: 60, alignment: .trailing)
                .font(.system(size: 50, weight: .semibold))
            Text(year)
                .padding()
                .font(.body)
            Spacer()
        }
    }
}

struct CalenderHeader_Previews: PreviewProvider {
    static var previews: some View {
        CalenderHeader(month: "2", year: "2022")
    }
}
