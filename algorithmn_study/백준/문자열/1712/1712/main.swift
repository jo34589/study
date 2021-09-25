//
//  main.swift
//  1712
//
//  Created by 조선우 on 2020/12/24.
//

//import Foundation

let arr = readLine()!.split(separator: " ").map { Int($0)! }

if arr[1] >= arr[2] {
    print(-1)
} else {
    print(arr[0] / (arr[2] - arr[1]) + 1)
}
