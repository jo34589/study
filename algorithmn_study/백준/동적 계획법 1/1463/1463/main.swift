//
//  main.swift
//  1463
//
//  Created by 조선우 on 2021/01/04.
//

//import Foundation
/*
var mem = Array(repeating: 0, count: 1000001)

let n = Int(readLine()!)!

mem[2] = 1
mem[3] = 1

if n < 3 {
    print(1)
} else {
    for i in 4 ... n {
        
        var candid = [Int](repeating: Int.max - 1, count: 3)
        
        if i % 2 == 0 {
            candid[0] = mem[i/2]
        }
        if i % 3 == 0 {
            candid[1] = mem[i/3]
        }
        candid[2] = mem[i-1]
        
        mem[i] = min(min(candid[0], candid[1]), candid[2]) + 1
        
    }
}

print(mem[n])
*/
// 위 방법은 시간초과가 남.

let n = Int(readLine()!)!

func dp(_ n: Int) -> Int {
    if n == 1 {
        return 0
    } else if n == 2 || n == 3 {
        return 1
    } else {
        return min(dp(n/2) + n%2, dp(n/3) + n%3) + 1
    }
}

print(dp(n))
//재귀로 시간통과
