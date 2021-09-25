//
//  main.swift
//  7568
//
//  Created by 조선우 on 2021/01/01.
//

//import Foundation

let n = Int(readLine()!)!
var arr = Array(repeating: [0, 0], count: n)
for i in 0 ..< n {
    let temp = readLine()!.split(separator: " ").map {Int($0)!}
    arr[i][0] = temp[0]
    arr[i][1] = temp[1]
}
//print(arr)

func isbigger (_ a: [Int], _ b: [Int]) -> Bool {
    //a 가 b 보다 덩치가 큰가?
    if a[0] > b[0] && a[1] > b[1] {
        return true
    } else {
        return false
    }
}

for i in 0 ..< n {
    var count = 1
    for j in 0 ..< n {
        if isbigger(arr[j], arr[i]) {
            count += 1
        }
    }
    print(count, separator: "", terminator: " ")
}

//print(arr)
