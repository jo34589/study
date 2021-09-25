//
//  main.swift
//  12015
//
//  Created by 조선우 on 2021/02/08.
//

let n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map() {Int($0)!}

var l = [Int]()
l.append(arr[0])
var last = 0
for index in 1 ..< arr.count {
    let num = arr[index]
    if num > l[last] {
        l.append(num)
        last += 1
    } else {
        var lower_bound = 0
        var upper_bound = last + 1
        while lower_bound < upper_bound {
            let mid = (lower_bound + upper_bound)/2
            let midval = l[mid]
            if midval >= num {
                upper_bound = mid
            } else {
                lower_bound = mid + 1
            }
        }
        l[lower_bound] = num
    }
}

print(l.count)
