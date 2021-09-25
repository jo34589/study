//
//  main.swift
//  3036
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

let n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map() {Int($0)!}

for i in 1 ..< n {
    let gcd = Gcd(arr[0], arr[i])
    print("\(arr[0]/gcd)/\(arr[i]/gcd)")
}
