//
//  main.swift
//  11050
//
//  Created by 조선우 on 2021/01/13.
//

var n_k = readLine()!.split(separator: " ").map {Int($0)!}
var ans = 1

if n_k[1] != 0 {
    for i in stride(from: n_k[0], to: n_k[0]-n_k[1], by: -1) {
        ans *= i
    }
    for i in stride(from: n_k[1], through: 1, by: -1) {
        ans /= i
    }
}

print(ans)
