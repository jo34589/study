//
//  main.swift
//  1676
//
//  Created by 조선우 on 2021/01/16.
//

let n = Int(readLine()!)!
if n == 0 {
    print(0)
} else {
    var count = 0
    for i in 1 ... n {
        if i % 5 == 0 {
            var x = i
            while x % 5 == 0  {
                count += 1
                x /= 5
            }
        }
    }
    print(count)
}

