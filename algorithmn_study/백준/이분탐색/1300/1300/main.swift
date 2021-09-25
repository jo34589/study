//
//  main.swift
//  1300
//
//  Created by 조선우 on 2021/02/06.
//

let n = Int(readLine()!)!
let k = Int(readLine()!)!

var m = Array(repeating: Array(repeating: 0, count: n), count: n)
for i in 1 ... n {
    for j in 1 ... n {
        m[i-1][j-1] = i*j
    }
}

func calc_index(_ m: [[Int]], _ n: Int) -> Int {
    let len = m.count
    var index = 0
    for i in 0 ..< len {
        for j in 0 ..< len {
            if m[i][j] <= n {
                index += 1
            }
        }
    }
    return index
}

var low = 1
var high = min(1000000000, n*n)

while low < high {
    let mid = (low + high) / 2
    let mid_index = calc_index(m, mid)
    if mid_index >= k {
        high = mid
    } else {
        low = mid + 1
    }
}

print(high)
