//
//  main.swift
//  2869
//
//  Created by 조선우 on 2020/12/27.
//

//import Foundation

let arr = readLine()!.split(separator: " ").map { Int($0)! }
//a = arr[0] / b = arr[1] / v = arr[2]

let c = (arr[2] - arr[0]) / (arr[0] - arr[1])

if (arr[2] - arr[0]) % (arr[0] - arr[1]) == 0 {
    print(c + 1)
} else {
    print(c + 2)
}
