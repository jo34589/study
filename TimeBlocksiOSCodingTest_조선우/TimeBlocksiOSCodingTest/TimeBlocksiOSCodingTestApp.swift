//
//  TimeBlocksiOSCodingTestApp.swift
//  TimeBlocksiOSCodingTest
//
//  Created by 엔나루 on 2022/02/18.
//

import SwiftUI

@main
struct TimeBlocksiOSCodingTestApp: App {
    
    @StateObject var eventHandler = EventHandler(date: Date(), events: [dummyEvent1])
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(eventHandler)
        }
    }
}
