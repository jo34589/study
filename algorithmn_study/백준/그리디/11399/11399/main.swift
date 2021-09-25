//
//  main.swift
//  11399
//
//  Created by 조선우 on 2021/01/11.
//

//import Foundation

let n = Int(readLine()!)!
var line = readLine()!.split(separator: " ").map() {Int($0)!}

line.sort()

var ans = 0
for i in 0 ..< n {
    ans += (line[i] * (n-i))
}

print(ans)
