//
//  main.swift
//  8958
//
//  Created by 조선우 on 2020/11/19.
//

import Foundation

let n: Int = Int(readLine()!)!
for _ in 0 ..< n {
    let str = readLine()!
    var score = [Int](repeating: 0, count: str.count)
    var si: Int = 0
    for i in str.indices {
        if i == str.startIndex {
            if str[i] == "O" {
                score[si] = 1
            } else {
                score[si] = 0
            }
        } else {
            if str[i] == "O" {
                score[si] = score[si-1] + 1
            } else {
                score[si] = 0
            }
        }
        si = si + 1
    }
    var sum = 0
    for num in score {
        sum = sum + num
    }
    print(sum)
}


