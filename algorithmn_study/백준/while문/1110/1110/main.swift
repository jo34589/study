//
//  main.swift
//  1110
//
//  Created by 조선우 on 2020/11/17.
//

import Foundation

let n: Int = Int(readLine()!)!
var count: Int = 0
var x: Int = n
repeat {
    var a: Int
    var b: Int
    if x < 10 {
        a = 0
        b = x
    } else {
        a = x/10
        b = x%10
    }
    let c = (a+b)%10
    x = b*10 + c
    count = count + 1
} while x != n

print(count)
