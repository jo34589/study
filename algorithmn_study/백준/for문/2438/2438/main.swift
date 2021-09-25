//
//  main.swift
//  2438
//
//  Created by 조선우 on 2020/11/17.
//

import Foundation

let n: Int = Int(readLine()!)!

for i in 0 ..< n {
    for _ in 0 ... i {
        print("*", terminator: "")
    }
    print()
}
