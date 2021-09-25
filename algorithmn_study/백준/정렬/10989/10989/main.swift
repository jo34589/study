//
//  main.swift
//  10989
//
//  Created by 조선우 on 2021/01/02.
//

//counting sort

var count = Array(repeating: 0, count: 10001)
let n = Int(readLine()!)!
var arr = Array(repeating: 0, count: n)
var ans = Array(repeating: 0, count: n+1)

for i in 0 ..< n {
    arr[i] = Int(readLine()!)!
    count[arr[i]] += 1
}

for i in 1 ... 10000 {
    count[i] = count [i] + count[i-1]
}

for i in 0 ..< n {
    ans[count[arr[i]]] = arr[i]
    count[arr[i]] -= 1
}

_ = ans.removeFirst()

for i in 0 ..< n {
    print(ans[i])
}
