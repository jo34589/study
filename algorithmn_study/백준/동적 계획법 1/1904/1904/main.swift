//
//  main.swift
//  1904
//
//  Created by 조선우 on 2021/01/04.
//

//import Foundation

var memo = [Int](repeating: 0, count: 1000001)
memo[1] = 1
memo[2] = 2

func fill_m() {
    for i in 3 ... 1000000 {
        var x = memo[i-1] + memo[i-2]
        if x >= 15746 {
            x = x % 15746
        }
        memo[i] = x
    }
}

fill_m()

let n = Int(readLine()!)!

print(memo[n])
