//
//  main.swift
//  2839
//
//  Created by 조선우 on 2020/12/24.
//

//import Foundation

let sugar = Int(readLine()!)!
var mem = [[Int]](repeating: Array(repeating: 0, count: 2), count: 5001)
//sugar = 3x + 5y

mem[3] = [1, 0]
mem[5] = [0, 1]

for i in 6 ... 5000 {
    if mem[i-5] != [0, 0] && mem[i-3] != [0, 0] {
        mem[i][0] = mem[i-5][0]
        mem[i][1] = mem[i-5][1] + 1
    } else if mem[i-3] != [0, 0] {
        mem[i][0] = mem[i-3][0] + 1
        mem[i][1] = mem[i-3][1]
    } else if mem[i-5] != [0, 0]{
        mem[i][0] = mem[i-5][0]
        mem[i][1] = mem[i-5][1] + 1
    } else {
        continue
    }
}

if mem[sugar] == [0, 0] {
    print(-1)
} else {
    print(mem[sugar][0] + mem[sugar][1])
}
