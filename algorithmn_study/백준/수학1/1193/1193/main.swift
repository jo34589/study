//
//  main.swift
//  1193
//
//  Created by 조선우 on 2020/12/26.
//

//import Foundation

let a = Int(readLine()!)!

//1, 3, 6, 10, 15, 21
// +2 +3  +4 +5  +6
// a_1 = 1
// a_n = (n+1)n/2
var n = 1
var x = 1

while a > x {
    x = ((n+1)*n)/2
    n += 1
}
//
