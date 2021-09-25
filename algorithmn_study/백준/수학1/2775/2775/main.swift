//
//  main.swift
//  2775
//
//  Created by 조선우 on 2020/12/27.
//

//import Foundation

var mem = Array(repeating: Array(repeating: 0, count: 15), count: 15)
mem[0] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
for i in 1 ... 14 {
    for j in 1 ... 14 {
        mem[i][j] = mem[i][j-1] + mem[i-1][j]
    }
}
//print(mem[14][14])
let t = Int(readLine()!)!
for _ in 0 ..< t {
    let x = Int(readLine()!)!
    let y = Int(readLine()!)!
    print(mem[x][y])
    
}
