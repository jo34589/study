//
//  main.swift
//  1011
//
//  Created by 조선우 on 2020/12/28.
//

//import Foundation

var ans = [Int]()
ans.append(0) //ans[0] == 0
ans.append(1) //ans[1] == 1
ans.append(2) //ans[2] == 2
var x = ans[2]
var i = 2
while (x < (UInt32.max/2)) {
    if i % 2 == 0 {
        ans.append(ans[i] + (i/2)+1)
    } else {
        ans.append(ans[i] + ((i-1)/2)+1 )
    }
    i += 1
    x = ans[i]
}

let t = Int(readLine()!)!

for _ in 0 ..< t {
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    let n = arr[1] - arr[0]
    var i = 1
    while ans[i] < n {
        i += 1
    }
    print(i)
}
