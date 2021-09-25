//
//  main.swift
//  9251
//
//  Created by 조선우 on 2021/01/10.
//

var s_a = readLine()!.map{String($0)}
var s_b = readLine()!.map{String($0)}
s_a.insert("0", at: 0)
s_b.insert("0", at: 0)

var dp = Array(repeating: Array(repeating: 0, count: s_a.count), count: s_b.count)
//O(N^2)
for i in 1 ..< s_b.count {
    for j in 1 ..< s_a.count {
        if s_b[i] == s_a[j] {
            dp[i][j] = dp[i-1][j-1] + 1
        } else {
            dp[i][j] = max(dp[i][j-1], dp[i-1][j])
        }
    }
}

let maxnum = dp[s_b.count-1].max()!
print(maxnum) //LCS 길이
/*
 var num = 0
var ans = [String]()
for i in 1 ..< s_a.count {
    for j in 1 ..< s_b.count {
        if dp[j][i] == num + 1  {
            ans.append(s_a[i])
            num += 1
        }
    }
}

print(ans.joined()) // LCS 구하기
*/
