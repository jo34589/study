//
//  main.swift
//  2750
//
//  Created by 조선우 on 2021/01/02.
//

let n = Int(readLine()!)!
var arr = Array(repeating: 0, count: n)
for i in 0 ..< n {
    arr[i] = Int(readLine()!)!
}

for i in 0 ..< n {
    for j in i+1 ..< n {
        if arr[i] > arr[j] {
            let temp = arr[j]
            arr[j] = arr[i]
            arr[i] = temp
        }
    }
}

for i in 0 ..< n {
    print(arr[i])
}
