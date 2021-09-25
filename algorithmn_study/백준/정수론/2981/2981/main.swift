//
//  main.swift
//  2981
//
//  Created by 조선우 on 2021/01/13.
//

import Foundation //sqrt

func Gcd(_ a: Int,_ b: Int) -> Int {
    let r = a % b
    if (r == 0) {
        return b
    } else {
        return Gcd(b, r);
    }
}

let n = Int(readLine()!)!
var arr = [Int]()
var subs = [Int]()
var gcds = [Int]()
arr.append(Int(readLine()!)!)

for i in 1 ..< n {
    arr.append(Int(readLine()!)!)
    subs.append(arr[i] - arr[i-1])
}

for i in 1 ..< n-1 {
    let x = Gcd(subs[i], subs[i-1])
    if !gcds.contains(x) {
        var add = true
        for j in 1 ..< n {
            if arr[j]%x != arr[j-1]%x {
                add = false
                break
            }
        }
        if add {
            gcds.append(x)
        }
    }
}
if subs.count == 1 {
    gcds.append(subs[0])
}
let m = gcds.max()!
var ans = [Int]()

for i in 1 ... Int(Double(m).squareRoot()) {
    if i*i == m {
        ans.append(i)
    }
    else if m%i == 0 {
        ans.append(i)
        ans.append(m/i)
    }
}

ans.sort()
ans.removeFirst()

for a in ans {
    print(a, separator: "", terminator: " ")
}
