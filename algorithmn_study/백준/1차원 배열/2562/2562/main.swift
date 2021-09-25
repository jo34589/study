//
//  main.swift
//  2562
//
//  Created by 조선우 on 2020/11/19.
//

import Foundation

var ans: Int = 0
var max: Int = -1

for i in 0 ..< 9 {
    let x = Int(readLine()!)!
    if (x > max) {
        max = x
        ans = i
    }
}

print(max)
print(ans+1)
