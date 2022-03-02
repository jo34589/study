//
//  EventAddDialogueView.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/18.
//

import SwiftUI

struct EventAddDialogueViewHost: View {
    
    @EnvironmentObject var eventHandler: EventHandler
    //@ObservedObject var calenderViewModel: CalenderViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width * 4/5
            let height = geometry.size.height * 2/5
            ZStack(alignment: .center) {
                Color(.gray)
                    .ignoresSafeArea()
                    .opacity(0.6)
                EventAddDialogueView()
                    .environmentObject(eventHandler)
                    .frame(width: width, height: height)
                    .cornerRadius(20)
            }
        }
    }
}

struct EventAddDialogueViewHost_Previews: PreviewProvider {
    static var previews: some View {
        EventAddDialogueViewHost()
            .environmentObject(EventHandler(date: Date(), events: []))
    }
}
