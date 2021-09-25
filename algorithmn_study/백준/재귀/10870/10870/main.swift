//
//  main.swift
//  10870
//
//  Created by 조선우 on 2020/12/31.
//

func fibo(_ n: Int) -> Int {
    if n == 0 {
        return 0
    } else if n == 1 {
        return 1
    } else {
        return fibo(n-1) + fibo(n-2)
    }
}

let n = Int(readLine()!)!

print(fibo(n))
