//
//  main.swift
//  1546
//
//  Created by 조선우 on 2020/11/19.
//

import Foundation

let n: Int = Int(readLine()!)!
var score = readLine()!.split(separator: " ").map { Double($0)! }
var max: Double = 0
for i in 0 ..< n {
    if max < score[i] {
        max = score[i]
    }
}
var sum: Double = 0
for i in 0 ..< n {
    score[i] = (score[i]/max) * 100
    sum = sum + score[i]
}
let ans = sum / Double(n)

print(ans)
