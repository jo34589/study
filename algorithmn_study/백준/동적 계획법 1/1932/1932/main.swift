//
//  main.swift
//  1932
//
//  Created by 조선우 on 2021/01/04.
//

//import Foundation

let size_n = Int(readLine()!)!
let first = Int(readLine()!)!
var max_sum = [Int](repeating: 0, count: 502)
max_sum[1] = first

for i in 2 ... size_n {
    let line = readLine()!.split(separator: " ").map{Int($0)!}
    let prev_max = max_sum[0 ... i+1]
    for j in 1 ... i {
        max_sum[j] = line[j-1] + max(prev_max[j], prev_max[j-1])
    }
}

print(max_sum.max()!)
