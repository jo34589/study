//
//  main.swift
//  10818
//
//  Created by 조선우 on 2020/11/19.
//

//import Foundation

let n: Int = Int(readLine()!)!
let input = readLine()!
let arr = input.split(separator: " ").map() {Int($0)!}
let minn = arr.min()
let maxn = arr.max()
print("\(minn) \(maxn)")

//뭣 때문인지 시간 초과가 난다.
