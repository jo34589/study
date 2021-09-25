//
//  main.swift
//  5622
//
//  Created by 조선우 on 2020/12/22.
//

//import Foundation

let word = readLine()!
var numword = [Int]()
let numA = Int(UnicodeScalar("A").value)
let timeA = 3
var ans = 0

for c in word {
    numword.append(Int(UnicodeScalar(String(c))!.value))
}

numword = numword.map({ ($0 - numA)})

//print(numword)

for n in numword {
    if 15 <= n && n <= 18 {
        ans += 8
    } else if 19 <= n && n <= 21 {
        ans += 9
    } else if 22 <= n {
        ans += 10
    } else {
        ans += (n / 3) + timeA
    }
    //print(ans)
}

print(ans)
