//
//  main.swift
//  2751
//
//  Created by 조선우 on 2021/01/02.
//

let n = Int(readLine()!)!
var arr = Array(repeating: 0, count: n)
for i in 0 ..< n {
    arr[i] = Int(readLine()!)!
}
arr.sort()
for i in 0 ..< n {
    print(arr[i])
}
