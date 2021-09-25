//
//  main.swift
//  2581
//
//  Created by 조선우 on 2020/12/28.
//

var prime = [Bool](repeating: true, count: 10001)
prime[0] = false
prime[1] = false

for i in 1 ... 10000 {
    if prime[i] == true {
        var x = i
        while x <= 10000 {
            prime[x] = false
            x += i
        }
        prime[i] = true
    }
}

let m = Int(readLine()!)!
let n = Int(readLine()!)!
var sum = 0
var min = 10001
for i in m ... n {
    if prime[i] == true {
        if min > i {
            min = i
        }
        sum += i
    }
}
if sum == 0 {
    print(-1)
} else {
    print(sum)
    print(min)
}
