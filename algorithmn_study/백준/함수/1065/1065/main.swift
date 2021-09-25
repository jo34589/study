//
//  main.swift
//  1065
//
//  Created by 조선우 on 2020/11/26.
//

import Foundation

var n = Int(readLine()!)!
var ans = 99

func isHansu (num: Int) -> Bool {
    var n = num
    var arr = [Int]()
    while n > 0 {
        arr.append(n%10)
        n = n / 10
    }
    arr.reverse()
    
    if ((arr[0] - arr[1]) == (arr[1] - arr[2])) {
        return true
    } else {
        return false
    }
}

if (n < 100) {
    print(n)
} else if n == 1000 {
    print("144")
} else {
    for i in 100 ... n {
        if isHansu(num: i) {
            ans = ans + 1
        } else {
            continue
        }
    }
    print(ans)
}

