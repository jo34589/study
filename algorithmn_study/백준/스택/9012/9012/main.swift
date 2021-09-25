//
//  main.swift
//  9012
//
//  Created by 조선우 on 2021/01/18.
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
for _ in 0 ..< n {
    var x = Stack(val: [])
    var ans = 1
    let line = readLine()!.map{String($0)}
    let len = line.count
    for i in 0 ..< len {
        if line[i] == "(" {
            x.push(i)
        } else {
            let a = x.pop()
            if a == -1 {
                ans = 0
                break
            }
        }
    }
    if ans == 1 && x.empty() == 0 {
        ans = 0
    }
    if ans == 1 {
        print("YES")
    } else {
        print("NO")
    }
}
