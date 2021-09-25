//
//  main.swift
//  10773
//
//  Created by 조선우 on 2021/01/17.
//

public struct Stack {
    var val: [Int]
    
    mutating func push (_ n: Int) {
        self.val.append(n)
    }
    mutating func pop () -> Int {
        if !self.val.isEmpty {
            return self.val.removeLast()
        } else {
            return -1
        }
    }
    mutating func size () -> Int {
        self.val.count
    }
    mutating func empty () -> Int {
        if self.val.isEmpty {
            return 1
        } else {
            return 0
        }
    }
    mutating func top () -> Int {
        if self.val.isEmpty {
            return -1
        } else {
            return self.val.last!
        }
    }
}

var x = Stack(val: [])
let n = Int(readLine()!)!
for _ in 0 ..< n {
    let q = Int(readLine()!)!
    if q != 0 {
        x.push(q)
    } else {
        _ = x.pop()
    }
}
var ans = 0
for num in x.val {
    ans += num
}
print(ans)
