//
//  ContentView.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/18.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var eventHandler: EventHandler
    
    var body: some View {
        ZStack {
            CalenderViewHost()
                .environmentObject(eventHandler)
                .ignoresSafeArea(.keyboard)
            if (eventHandler.isAdding) {
                EventAddDialogueViewHost()
                    .environmentObject(eventHandler)
                    .ignoresSafeArea(.keyboard)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(EventHandler(date: Date(), events: [dummyEvent1]))
    }
}
