//
//  main.swift
//  11720
//
//  Created by 조선우 on 2020/11/26.
//

import Foundation

let n = Int(readLine()!)!
var str = readLine()!
var ans:Int = 0

for char in str {
    ans = ans + Int(String(char))!
}

print(ans)
