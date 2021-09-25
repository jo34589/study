//
//  main.swift
//  11053
//
//  Created by 조선우 on 2021/01/05.
//
// 가장 긴 증가하는 부분 수열

//import Foundation

let n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map {Int($0)!}
var dp = Array(repeating: 1, count: n)

//dp[i] = length of longest subsequences which takes i-th elememt as end of subsequence

//O(N^2)
for i in 0 ..< n {
    let last_val = arr[i]
    for j in 0 ..< i {
        let target_val = arr[j]
        if last_val > target_val {
            dp[i] = max(dp[i], dp[j] + 1)
        }
    }
}

print(dp.max()!)
