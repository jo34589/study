//
//  main.swift
//  1934
//
//  Created by 조선우 on 2021/01/13.
//

func Gcd(_ a: Int,_ b: Int) -> Int {
    let r = a % b
    if (r == 0) {
        return b
    } else {
        return Gcd(b, r);
    }
}

let t = Int(readLine()!)!
for _ in 0 ..< t {
    let num = readLine()!.split(separator: " ").map {Int($0)!}
    let gcd = Gcd(num[0], num[1])
    print(num[0]*num[1]/gcd)
}
