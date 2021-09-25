//
//  main.swift
//  2231
//
//  Created by 조선우 on 2021/01/01.
//

//import Foundation

let n = Int(readLine()!)!
var ans = 0

for i in 1 ..< n {
    var x = 0
    var temp = i
    x += temp
    while temp != 0 {
        x += temp % 10
        temp = temp / 10
    }
    if x == n {
        ans = i
        break
    }
}
if n < 10 {
    ans = 0
}
print(ans)
