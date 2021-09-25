//
//  main.swift
//  2156
//
//  Created by 조선우 on 2021/01/05.
//

//import Foundation

let n = Int(readLine()!)!

var inw = Array(repeating: 0, count: n+1)
var maxw = Array(repeating: 0, count: n+1)

for i in 1 ... n {
    inw[i] = Int(readLine()!)!
}

if n == 1 {
    print(inw[1])
} else if n == 2 {
    print(inw[1]+inw[2])
} else {
    maxw[1] = inw[1]
    maxw[2] = inw[1]+inw[2]
    for i in 3 ... n {
        var c = [Int]()
        c.append(maxw[i-1])
        c.append(maxw[i-3] + inw[i-1] + inw[i])
        c.append(maxw[i-2] + inw[i])
        maxw[i] = c.max()!
    }
    print(maxw[n])
}
