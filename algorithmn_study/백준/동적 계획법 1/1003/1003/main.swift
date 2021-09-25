//
//  main.swift
//  1003
//
//  Created by 조선우 on 2021/01/03.
//

//import Foundation

var ans = Array(repeating: [0, 0], count: 41)
ans[0] = [1, 0]
ans[1] = [0, 1]

func fib_calc() {
    for i in 2 ... 40 {
        ans[i][0] = ans[i-2][0] + ans[i-1][0]
        ans[i][1] = ans[i-2][1] + ans[i-1][1]
    }
}

fib_calc()
let t = Int(readLine()!)!

for _ in 0 ..< t {
    let x = Int(readLine()!)!
    print(ans[x][0], separator: "", terminator: " ")
    print(ans[x][1])
}
