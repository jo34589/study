//
//  main.swift
//  2675
//
//  Created by 조선우 on 2020/12/21.
//

import Foundation

let t = Int(readLine()!)!
var ans = [String]()

for _ in 0 ..< t {
    let line = readLine()!
    let q = line.split(separator: " ").map { String($0) }
    let num = Int(q[0])!
    for char in q[1] {
        for _ in 0 ..< num {
            print(char, separator: "", terminator: "")
        }
    }
    print()
}
