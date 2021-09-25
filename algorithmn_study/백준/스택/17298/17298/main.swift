//
//  main.swift
//  17298
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
        return self.val.isEmpty
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
let a = readLine()!.split(separator: " ").map() {Int($0)!}
var nge = Array(repeating: 0, count: n)
var x = Stack(val: [])

for i in 0 ..< n {
    if x.empty() {
        x.push(i)
    } else if a[x.top()!] >= a[i] {
        x.push(i)
    } else {
        while !x.empty() && a[x.top()!] < a[i] {
            nge[x.pop()!] = a[i]
        }
        x.push(i)
    }
}

while (!x.empty()) {
    nge[x.pop()!] = -1
}

for n in nge {
    print(n, separator: "", terminator: " ")
}

