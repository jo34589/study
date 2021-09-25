//
//  main.swift
//  10871
//
//  Created by 조선우 on 2020/11/17.
//

import Foundation

let nx = readLine()!.split(separator: " ").map { Int($0)! }
let intArr = readLine()!.split(separator: " ").map { Int($0)! }

//print(nx)
//print(intArr)

for num in intArr {
    if (num < nx[1]) {
        print(num, terminator: " ")
    }
}
