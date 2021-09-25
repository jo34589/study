//
//  main.swift
//  2565
//
//  Created by 조선우 on 2021/01/06.
//

//import Foundation

//정렬 후 a->b 로 가장 긴 증가하는 부분 수열을 만든다....
//전체 n 중에서 가장 긴 부분 수열의 길이를 뺀다.

let n = Int(readLine()!)!
var line = Array(repeating: [Int]() , count: 0)
var dp = [Int](repeating: 1, count: n)

line.append(readLine()!.split(separator: " ").map{Int($0)!})
line.append([501, 501])


for i in 1 ..< n {
    let new = readLine()!.split(separator: " ").map{Int($0)!}
    for j in 0 ... i {
        if line[j][0] > new[0] {
            line.insert(new, at: j)
            break
        }
    }
}
_ = line.removeLast()

for i in 0 ..< n {
    let current = line[i][1]
    for j in 0 ... i {
        let target = line[j][1]
        if current > target {
            dp[i] = max(dp[i], dp[j] + 1)
        }
    }
}

print(n - dp.max()!)
