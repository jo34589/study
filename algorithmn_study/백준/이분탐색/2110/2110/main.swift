//
//  main.swift
//  2110
//
//  Created by 조선우 on 2021/02/06.
//

//최소거리 d 가 작을수록, 설치할 수 있는 갯수가 늘어난다.<= 를 이용한 이분탐색

func install(_ arr: [Int], _ d: Int) -> Int {
    var position = arr[0]
    var inst = 1
    let last = arr[arr.count-1]
    for i in 1 ... arr.count-1 {
        if position + d > last {
            break
        }
        if position + d <= arr[i] {
            position = arr[i]
            inst += 1
        }
    }
    return inst
}

let n_c = readLine()!.split(separator: " ").map() {Int($0)!}
var min = 1000000001
var max = -1
var arr = [Int]()
for _ in 0 ..< n_c[0] {
    let temp = Int(readLine()!)!
    arr.append(temp)
    if temp < min {
        min = temp
    }
    if temp > max {
        max = temp
    }
}
arr.sort() // 20만 log(20만)

var low = 1
var high = max - min + 1

//20만 log(10억)

while low < high {
    let mid = (low + high) / 2
    let midval = install(arr, mid)
    if midval < n_c[1] {
        high = mid
    } else {
        low = mid + 1
    }
}

print(high-1)
