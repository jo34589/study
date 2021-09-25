//
//  main.swift
//  2884
//
//  Created by 조선우 on 2020/11/17.
//

import Foundation

var timeArr = readLine()!.split(separator: " ").map { Int($0) }
var h = timeArr[0]!
var m = timeArr[1]!

if( m >= 45) {
    print("\(h) \(m-45)")
} else {
    if (h > 0) {
        print("\(h-1) \(m+15)")
    } else {
        print("23 \(m+15)")
    }
}
