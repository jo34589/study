//
//  main.swift
//  1929
//
//  Created by 조선우 on 2020/12/28.
//

var prime = [Bool](repeating: true, count: 1000001)
prime[0] = false
prime[1] = false

for i in 1 ... 1000000 {
    if prime[i] == true {
        var x = i
        while x <= 1000000 {
            prime[x] = false
            x += i
        }
        prime[i] = true
    }
}

let arr = readLine()!.split(separator: " ").map {Int($0)!}

for num in arr[0] ... arr[1] {
    if prime[num] == true {
        print(num)
    }
}
