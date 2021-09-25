//
//  main.swift
//  4673
//
//  Created by 조선우 on 2020/11/23.
//

import Foundation

var d = [Bool](repeating: true, count: 10001)

func makeSlefNum (num: Int) -> Int {
    var n = num
    var newn: Int = n
    while n > 0 {
        newn = newn + (n%10)
        n = n / 10
    }
    return newn
}

for i in 1 ... 10000 {
    if(d[i] == true) {
        print(i)
        var j = i
        while makeSlefNum(num: j) <= 10000 {
            j = makeSlefNum(num: j)
            d[j] = false
        }
    } else {
        continue
    }
}
