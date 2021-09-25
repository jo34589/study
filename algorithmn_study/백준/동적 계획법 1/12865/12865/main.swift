//
//  main.swift
//  12865
//
//  Created by 조선우 on 2021/01/10.
//
//import Foundation

let n_k = readLine()!.split(separator: " ").map {Int($0)!}
var package = Array(repeating: [0, 0], count: 1)
let n = n_k[0]
let k = n_k[1]
var dp = Array(repeating: Array(repeating: 0, count: n+1), count: k+1)
for _ in 0 ..< n {
    let input = readLine()!.split(separator: " ").map{Int($0)!}
    package.append(input)
}

for i in 1 ... k {
    for j in 1 ... n {
        let weight = package[j][0]
        let val = package[j][1]
        if i >= weight {
            dp[i][j] = max(dp[i-weight][j-1]+val, dp[i][j-1])
        } else {
            dp[i][j] = dp[i][j-1]
        }
    }
}

print(dp[k][n])
