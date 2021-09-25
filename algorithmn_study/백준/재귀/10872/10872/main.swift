//
//  main.swift
//  10872
//
//  Created by 조선우 on 2020/12/31.
//

func factorial(_ n: Int) -> Int {
    if n == 0 {
        return 1
    } else if n == 1 {
        return 1
    } else {
        return n * factorial(n-1)
    }
}

let n = Int(readLine()!)!
let ans = factorial(n)

print(ans)
