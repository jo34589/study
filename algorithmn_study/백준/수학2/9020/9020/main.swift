//
//  main.swift
//  9020
//
//  Created by 조선우 on 2020/12/29.
//

//import Foundation

var prime = [Bool](repeating: true, count: 10008)
var primearr = [Int]()
prime[0] = false
prime[1] = false

for i in 1 ... 10007 {
    if prime[i] == true {
        var x = i
        while x <= 10007 {
            prime[x] = false
            x += i
        }
        prime[i] = true
        primearr.append(i)
    }
}

func goldbach (_ num: Int) -> [Int] {
    var rtn = [0, 0]
    var max_i = 0
    while primearr[max_i] < num {
        max_i += 1
    }
    var diff = 10000
    for i in 0 ... max_i {
        for j in i ... max_i {
            if primearr[i] + primearr[j] == num {
                if (j - i) < diff {
                    rtn[0] = primearr[i]
                    rtn[1] = primearr[j]
                    diff = j - i
                }
            }
        }
    }
    
    return rtn
}

let t = Int(readLine()!)!

for _ in 0 ..< t {
    let n = Int(readLine()!)!
    let ans = goldbach(n)
    print(ans[0], separator: "", terminator: " ")
    print(ans[1])
    
}
