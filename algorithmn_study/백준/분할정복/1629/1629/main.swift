//
//  main.swift
//  1629
//
//  Created by 조선우 on 2021/01/28.
//

func power(a: Int, b: Int, c: Int) -> Int {
    if b == 0 {
        return 1
    }
    
    let n = power(a: a, b: b/2, c: c)
    let temp = n * n % c
    
    if b % 2 == 0 {
        return temp
    } else {
        return a * temp % c
    }
}

let line = readLine()!.split(separator: " ").map() {Int($0)!}

let p = power(a: line[0], b: line[1], c: line[2])

print(p)
