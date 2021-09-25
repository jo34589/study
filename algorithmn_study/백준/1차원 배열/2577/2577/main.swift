//
//  main.swift
//  2577
//
//  Created by 조선우 on 2020/11/19.
//

import Foundation

let a: Int = Int(readLine()!)!
let b: Int = Int(readLine()!)!
let c: Int = Int(readLine()!)!

let n: Int = (a * b) * c
let numstring = String(n)

var ans = [0,0,0,0,0,0,0,0,0,0]

for i in numstring.indices {
    switch numstring[i] {
    case "0":
        ans[0] = ans[0] + 1
    case "1":
        ans[1] = ans[1] + 1
    case "2":
        ans[2] = ans[2] + 1
    case "3":
        ans[3] = ans[3] + 1
    case "4":
        ans[4] = ans[4] + 1
    case "5":
        ans[5] = ans[5] + 1
    case "6":
        ans[6] = ans[6] + 1
    case "7":
        ans[7] = ans[7] + 1
    case "8":
        ans[8] = ans[8] + 1
    case "9":
        ans[9] = ans[9] + 1
    default:
        print("error")
    }
}
for aa in ans {
    print(aa)
}
