//
//  main.swift
//  1436
//
//  Created by 조선우 on 2021/01/02.
//

//import Foundation
/*
 while t >= 666 {
    if (t-666) % 1000 == 0 {
        return true
    }
    t /= 10
}
*/

//딱히 효율적인 풀이는 아니었다.
let n = Int(readLine()!)!
var ans  = 0

var i = 1
var x = 1665
while true {
    if i == n {
        break
    }
    x += 1
    let temp = String(x).map{String($0)}
    for j in 0 ..< temp.count-2 {
        if (temp[j] == "6") && (temp[j+1] == "6") && (temp[j+2] == "6") {
            i += 1
            ans = x
            break
        }
    }
}

if n == 1 {
    ans = 666
}

print(ans)
