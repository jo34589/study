//
//  main.swift
//  1874
//
//  Created by 조선우 on 2021/01/18.
//

public struct Stack {
    var val: [Int]
    
    mutating func push (_ n: Int) {
        self.val.append(n)
    }
    mutating func pop () -> Int? {
        if !self.val.isEmpty {
            return self.val.removeLast()
        } else {
            return nil
        }
    }
    mutating func size () -> Int {
        self.val.count
    }
    mutating func empty () -> Bool {
        if self.val.isEmpty {
            return true
        } else {
            return false
        }
    }
    mutating func top () -> Int? {
        if self.val.isEmpty {
            return nil
        } else {
            return self.val.last!
        }
    }
}

let n = Int(readLine()!)!
var ans = ["+"]
var s = Stack(val: [1])
var i = 1
for _ in 0 ..< n {
    let x = Int(readLine()!)!
    while s.top() != x {
        i += 1
        s.push(i)
        ans.append("+")
        if i > x {
            break
        }
    }
    if x == s.top() {
        _ = s.pop()
        ans.append("-")
    } else {
        ans = ["NO"]
        break
    }
}
for a in ans {
    print(a)
}
