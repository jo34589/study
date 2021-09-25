//
//  main.swift
//  1920
//
//  Created by 조선우 on 2021/02/02.
//

let n = Int(readLine()!)!
var arr = readLine()!.split(separator: " ").map() {Int($0)!}
let m = Int(readLine()!)!
let line = readLine()!.split(separator: " ").map() {Int($0)!}

arr.sort()

func binary_search (_ arr: [Int], _ n: Int) -> Int {
    var low = 0
    var high = arr.count - 1
    while (low <= high) {
        let mid = (low + high) / 2
        if arr[mid] == n {
            return arr[mid]
        }
        if arr[mid] > n {
            high = mid-1
        } else {
            low = mid+1
        }
    }
    return -1
}

for num in line {
    if binary_search(arr, num) == -1 {
        print(0)
    } else {
        print(1)
    }
}
