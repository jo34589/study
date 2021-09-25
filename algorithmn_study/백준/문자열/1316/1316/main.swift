//
//  main.swift
//  1316
//
//  Created by 조선우 on 2020/12/24.
//

//import Foundation

func isGroupN(word: String) -> Bool {
    let arr = word.map {$0}
    var checker = [Character]()
    
    for i in 0 ..< (arr.count - 1) {
        if checker.contains(arr[i]) == false{
            checker.append(arr[i])
        }
        if arr[i] != arr[i+1] {
            if (checker.contains(arr[i+1])) {
                return false
            }
        }
    }
    return true
}

let numt = Int(readLine()!)!
var ans = 0

for _ in 0 ..< numt {
    let w = readLine()!
    if isGroupN(word: w) {
        ans += 1
    }
}

print(ans)
