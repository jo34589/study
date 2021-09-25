//
//  main.swift
//  B
//
//  Created by 조선우 on 2021/01/09.
//

let n_t = readLine()!.split(separator: " ").map {Int($0)!}
var h = [0]
h.append(contentsOf: (readLine()!.split(separator: " ").map {Int($0)!}))

var dp = Array(repeating: Array(repeating: 0, count: n_t[0]+1), count: n_t[1]+1)

for t in 1 ... n_t[1] {
    for n in 1 ... n_t[0] {
        if n > t+1 {
            dp[t][n] = 0
        } else {
            if n == 1 {
                dp[t][n] = max(dp[t-1][n], dp[t-1][n+1] + h[n])
            } else if n == n_t[0] {
                dp[t][n] = max(dp[t-1][n], dp[t-1][n-1] + h[n])
            } else {
                dp[t][n] = max(dp[t-1][n], max(dp[t-1][n-1] + h[n], dp[t-1][n+1] + h[n]))
            }
        }
    }
}

print(dp[n_t[1]][1])
