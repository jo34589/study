//
//  main.swift
//  2439
//
//  Created by 조선우 on 2020/11/17.
//

import Foundation

let n: Int = Int(readLine()!)!

for i in 1 ... n {
    for _ in 0 ..< (n-i) {
        print(" ", terminator: "")
    }
    for _ in 0 ..< i {
        print("*", terminator: "")
    }
    print()
}
