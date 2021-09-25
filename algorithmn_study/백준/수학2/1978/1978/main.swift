//
//  main.swift
//  1978
//
//  Created by 조선우 on 2020/12/28.
//
//import Foundation

var prime = [Bool](repeating: true, count: 1001)
prime[0] = false
prime[1] = false

for i in 1 ... 1000 {
    if prime[i] == true {
        var x = i
        while x <= 1000 {
            prime[x] = false
            x += i
        }
        prime[i] = true
    }
}

_ = readLine()
let arr = readLine()!.split(separator: " ").map { Int($0)! }
var ans = 0
for num in arr {
    if prime[num] == true {
        ans += 1
    }
}
print(ans)
