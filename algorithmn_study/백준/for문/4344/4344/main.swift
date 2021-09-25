//
//  main.swift
//  4344
//
//  Created by 조선우 on 2020/11/23.
//

import Foundation

let c: Int = Int(readLine()!)!

for _ in 0 ..< c {
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    var sum = 0
    for i in 1 ... arr[0] {
        sum = sum + arr[i]
    }
    let mean = Double(sum) / Double(arr[0])
    var count = 0
    for j in 1 ... arr[0] {
        if Double(arr[j]) > mean{
            count = count + 1
        }
    }
    var ans = Double(count) / Double(arr[0])
    ans = round(ans * 100000) / 1000
    let ans_s = String(format: "%.3f", ans)
    print(ans_s + "%")
}

