//
//  main.swift
//  2579
//
//  Created by 조선우 on 2021/01/04.
//

let n = Int(readLine()!)!
var max_n = Array(repeating: [0, 0], count: n+1)

if n == 1 {
    max_n[1][0] = Int(readLine()!)!
    print(max_n[1][0])
} else if n == 2 {
    max_n[1][0] = Int(readLine()!)!
    max_n[2][1] = Int(readLine()!)!
    max_n[2][0] = max_n[1][0] + max_n[2][1]
    print(max_n[2][0])
} else {
    max_n[1][0] = Int(readLine()!)!
    max_n[2][1] = Int(readLine()!)!
    max_n[2][0] = max_n[1][0] + max_n[2][1]
    for i in 3 ... n {
        let new = Int(readLine()!)!
        max_n[i][0] = max_n[i-1][1] + new
        max_n[i][1] = max(max_n[i-2][0], max_n[i-2][1]) + new
    }
    print(max(max_n[n][0], max_n[n][1]))
}
