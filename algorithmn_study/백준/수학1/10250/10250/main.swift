//
//  main.swift
//  10250
//
//  Created by 조선우 on 2020/12/27.
//

//import Foundation

let t = Int(readLine()!)!

for _ in 0 ..< t {
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    var x = arr[2] / arr[0]
    var y = arr[2] % arr[0]
    if y == 0 {
        y += arr[0]
        x -= 1
    }
    print(100 * y + x + 1)
}
