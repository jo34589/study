//
//  main.swift
//  2805
//
//  Created by 조선우 on 2021/02/05.
//

func calc(_ arr: [Int], _ val: Int) -> Int {
    var rtn = 0
    for num in arr {
        if val < num {
            rtn += (num - val)
        }
    }
    return rtn
}

let n_m = readLine()!.split(separator: " ").map() {Int($0)!}
var trees = readLine()!.split(separator: " ").map() {Int($0)!}
var low = 0
var high = trees.max()! + 1

while low < high {
    let mid = (low + high) / 2
    let midval = calc(trees, mid)
    if midval >= n_m[1] {
        low = mid + 1
    } else {
        high = mid
    }
}

print(high - 1)
