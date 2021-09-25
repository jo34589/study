//
//  main.swift
//  2609
//
//  Created by 조선우 on 2021/01/12.
//

// 유클리드 호제법
func Gcd(_ a: Int,_ b: Int) -> Int {
    let r = a % b
    if (r == 0) {
        return b
    } else {
        return Gcd(b, r);
    }
}

let num = readLine()!.split(separator: " ").map {Int($0)!}
let gcd = Gcd(num[0], num[1])
let lcm = num[0] * num[1] / gcd

print(gcd)
print(lcm)
