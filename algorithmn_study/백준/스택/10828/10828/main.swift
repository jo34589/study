//
//  main.swift
//  10828
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

let n = Int(readLine()!)!
var x = Stack(val: [])
for _ in 0 ..< n {
    let q = readLine()!.split(separator: " ").map{String($0)}
    if q[0] == "push" {
        x.push(Int(q[1])!)
    } else if q[0] == "pop" {
        print(x.pop())
    } else if q[0] == "size" {
        print(x.size())
    } else if q[0] == "empty" {
        print(x.empty())
    } else if q[0] == "top" {
        print(x.top())
    } else {
        print("query error")
    }
}
