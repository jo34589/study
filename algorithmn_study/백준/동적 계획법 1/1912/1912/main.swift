//
//  main.swift
//  1912
//
//  Created by 조선우 on 2021/01/10.
//

let n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map{Int($0)!}
var maxsum = -1001
var dp = Array(repeating: 0, count: n)

dp[0] = arr[0]
maxsum = dp[0]
for i in 1 ..< n {
    dp[i] = arr[i] + max(dp[i-1], 0)
    if maxsum < dp[i] {
        maxsum = dp[i]
    }
}

print(maxsum)
