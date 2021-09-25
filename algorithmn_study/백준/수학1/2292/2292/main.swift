//
//  main.swift
//  2292
//
//  Created by 조선우 on 2020/12/24.
//

//import Foundation

//1             1
//2 ~ 7         2
//8 ~ 19        3
//20 ~ 37       4
//38 ~ 61       5
//62 ~
//1, 2,  3,  4,  5
//1, 7, 19, 37, 61, ?
// +6 +12 +18 +24
//계차수열이었다.

let cellnum = Int(readLine()!)!
var num = 1
var ans = 1
while num < cellnum {
    num += 6 * ans
    ans += 1
}

print(ans)
