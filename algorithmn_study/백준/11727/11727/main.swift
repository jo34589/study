//
//  main.swift
//  11727
//
//  Created by 조선우 on 2021/02/05.
//

// N = N-1 + 2*(N-2)

var dp = Array(repeating: 0, count: 1001)

let n = Int(readLine()!)!

dp[1] = 1
dp[2] = 3

if n >= 3 {
    for i in 3 ... n {
        dp[i] = (dp[i-1] + 2*dp[i-2]) % 10007
    }
}

print(dp[n])
