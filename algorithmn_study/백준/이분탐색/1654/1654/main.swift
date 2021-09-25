//
//  main.swift
//  1654
//
//  Created by 조선우 on 2021/02/04.
//

let n_m = readLine()!.split(separator: " ").map() {Int($0)!}
var arr = [Int]()
var x = -1
for _ in 0 ..< n_m[0] {
    let temp = Int(readLine()!)!
    if temp > x {
        x = temp
    }
    arr.append(temp)
}
var utp = Array(repeating: [0, 0], count: 0)

var lower_bound = 0
var upper_bound = x+1

while lower_bound < upper_bound {
    let mid = (lower_bound + upper_bound) / 2
    let midval = calc(mid)
    if midval >= n_m[1] {
        lower_bound = mid + 1
    } else {
        upper_bound = mid
    }
}

func calc(_ x: Int) -> Int {
    var cable = 0
    for num in arr {
        cable += (num/x)
    }
    return cable
}

print(upper_bound - 1)
