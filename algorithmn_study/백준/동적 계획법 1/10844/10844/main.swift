//
//  main.swift
//  10844
//
//  Created by 조선우 on 2021/01/05.
//

//import Foundation

var mem = Array(repeating: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], count: 101)
mem[1] = [0, 1, 1, 1, 1, 1, 1, 1, 1, 1]

for i in 1 ... 99 {
    for j in 0 ... 9 {
        if j == 0 {
            mem[i+1][0] = mem[i][1]
        } else if j == 9 {
            mem[i+1][9] = mem[i][8]
        } else {
            mem[i+1][j] = (mem[i][j+1] + mem[i][j-1]) % 1000000000
        }
    }
}

let n = Int(readLine()!)!
var ans = 0
for i in 0 ... 9 {
    ans += mem[n][i]
    ans %= 1000000000
}
print(ans)
