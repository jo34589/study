//
//  main.swift
//  1002
//
//  Created by 조선우 on 2020/12/30.
//

import Foundation

let t = Int(readLine()!)!
var ans = [Int]()

for _ in 0 ..< t {
    let arr = readLine()!.split(separator: " ").map{ Double($0)! }

    let d_x = arr[3] - arr[0]
    let d_y = arr[4] - arr[1]
    let d = (d_x*d_x + d_y*d_y).squareRoot()

    //내포x
    if d + min(arr[2], arr[5]) > max(arr[2], arr[5]) {
        if d > arr[2] + arr[5] {
            ans.append(0)
        } else if d == arr[2] + arr[5] {
            ans.append(1)
        } else {
            ans.append(2)
        }
    } else if d + min(arr[2], arr[5]) == max(arr[2], arr[5]) {
        if d == 0.0 {
            ans.append(-1)
        } else {
            ans.append(1)
        }
    } else {
        ans.append(0)
    }
}

for i in ans {
    print(i)
}
