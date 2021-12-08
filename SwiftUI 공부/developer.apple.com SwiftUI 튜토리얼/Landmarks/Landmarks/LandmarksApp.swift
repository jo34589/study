//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by 엔나루 on 2021/11/29.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
