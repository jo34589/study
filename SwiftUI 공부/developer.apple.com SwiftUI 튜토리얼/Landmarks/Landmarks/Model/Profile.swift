//
//  Profile.swift
//  Landmarks
//
//  Created by 엔나루 on 2021/12/12.
//

import Foundation

struct Profile {
    var username: String
    var perfersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()
    
    static let `default` = Profile(username: "g_kumar")
    
    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌹"
        case summer = "🌞"
        case autumn = "🍁"
        case winter = "⛄️"
        
        var id: String { rawValue }
    }
}
