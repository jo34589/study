//
//  main.swift
//  1085
//
//  Created by 조선우 on 2020/12/29.
//

let arr = readLine()!.split(separator: " ").map { Int($0)! }
print(min(min(arr[0], arr[2] - arr[0]), min(arr[1], arr[3] - arr[1])))
