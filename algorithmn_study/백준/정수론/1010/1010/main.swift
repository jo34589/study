//
//  main.swift
//  1010
//
//  Created by 조선우 on 2021/01/14.
//
let t = Int(readLine()!)!
var bc = Array(repeating: Array(repeating: 0, count: 31), count: 31)
var ans = 0

for n in 0 ... 30 {
    bc[n][0] = 1
    bc[n][1] = n
    bc[n][n] = 1
}
bc[0][1] = 1
for n in 2 ... 30 {
    for k in 2 ..< n {
        bc[n][k] = (bc[n-1][k-1] + bc[n-1][k])
    }
}

for _ in 0 ..< t {
    let line = readLine()!.split(separator: " ").map {Int($0)!}
    print(bc[line[1]][line[0]])
}
