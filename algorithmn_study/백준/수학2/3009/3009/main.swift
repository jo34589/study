//
//  main.swift
//  3009
//
//  Created by 조선우 on 2020/12/29.
//

//import Foundation

let a = readLine()!.split(separator: " ").map {Int($0)!}
let b = readLine()!.split(separator: " ").map {Int($0)!}
let c = readLine()!.split(separator: " ").map {Int($0)!}
var ans = [Int]()
for i in 0 ... 1 {
    if a[i] == b[i] {
        ans.append(c[i])
    } else if a[i] == c[i] {
        ans.append(b[i])
    } else if b[i] == c[i] {
        ans.append(a[i])
    }
}
print(ans[0], separator: "", terminator: " ")
print(ans[1])
