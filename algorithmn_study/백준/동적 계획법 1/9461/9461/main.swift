//
//  main.swift
//  9461
//
//  Created by 조선우 on 2021/01/04.
//

//import Foundation

var p = [Int](repeating: 0, count: 101)

p[1] = 1
p[2] = 1
p[3] = 1
p[4] = 2
p[5] = 2

for i in 6 ... 100 {
    p[i] = p[i-1] + p[i-5]
}

for _ in 0 ..< Int(readLine()!)! {
    let n = Int(readLine()!)!
    print(p[n])
}
