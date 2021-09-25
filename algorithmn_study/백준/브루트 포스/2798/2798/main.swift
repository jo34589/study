//
//  main.swift
//  2798
//
//  Created by 조선우 on 2021/01/01.
//

//import Foundation

let n_m = readLine()!.split(separator: " ").map {Int($0)!}
let cards = readLine()!.split(separator: " ").map {Int($0)!}
let count = n_m[0]
let m = n_m[1]
var ans = 0

func sum(_ a:Int, _ b:Int, _ c:Int) -> Int {
    if cards[a] + cards[b] + cards[c] > m {
        return -1
    } else {
        return cards[a] + cards[b] + cards[c]
    }
}

for i in 0 ..< count-2 {
    for j in i+1 ..< count-1 {
        for k in j+1 ..< count {
            let new = sum(i, j, k)
            if new > ans {
                ans = new
            }
        }
    }
}

print(ans)
