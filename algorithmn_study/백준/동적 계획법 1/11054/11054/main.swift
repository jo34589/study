//
//  main.swift
//  11054
//
//  Created by 조선우 on 2021/01/06.
//

let n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map {Int($0)!}

var dp = Array(repeating: [1, 0], count: n)

for i in 0 ..< n {
    let now = arr[i]
    for j in 0 ..< i {
        let target = arr[j]
        if now > target {
            dp[i][0] = max(dp[i][0], dp[j][0] + 1)
        }
        
    }
}
for i in stride(from: n-1, through: 0, by: -1) {
    let now = arr[i]
    for j in stride(from: n-1, through: i, by: -1) {
        let target = arr[j]
        if now > target {
            dp[i][1] = max(dp[i][1], dp[j][1] + 1)
        }
    }
}

var ans = 0
/*
for i in 0 ..< n {
    print(dp[i][0], separator: "", terminator: " ")
}
print("")
for i in 0 ..< n {
    print(dp[i][1], separator: "", terminator: " ")
}
*/
for i in 0 ..< n {
    if ans < dp[i][0] + dp[i][1] {
        ans = dp[i][0] + dp[i][1]
    }
}
print(ans)
