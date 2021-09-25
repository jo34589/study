//
//  main.swift
//  3052
//
//  Created by 조선우 on 2020/11/19.
//

import Foundation

var arr = [Int](repeating: 0, count: 42)
var count: Int = 0
for _ in 0 ..< 10 {
    let x = Int(readLine()!)!
    
    if(arr[x%42] == 0) {
        arr[x%42] = 1
        count = count + 1
    }
    
}

print(count)
