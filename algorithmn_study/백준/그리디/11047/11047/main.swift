//
//  main.swift
//  11047
//
//  Created by 조선우 on 2021/01/11.
//

//import Foundation

let n_k = readLine()!.split(separator: " ").map{Int($0)!}
let n = n_k[0]
let k = n_k[1]
var coins = [Int]()
var ans = 0
for _ in 0 ..< n {
    coins.append(Int(readLine()!)!)
}

func coins(input: Int) -> Int {
    if input > coins[n-1] {
        ans += input / coins[n-1]
        return input % coins[n-1]
    } else {
        var m = 0
        for i in 0 ..< n {
            if input < coins[i] {
                m = i - 1
                break
            }
        }
        ans += input / coins[m]
        return input % coins[m]
    }
}

var x = coins(input: k)
while x != 0 {
    x = coins(input: x)
}

print(ans)
