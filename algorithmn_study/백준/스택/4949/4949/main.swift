//
//  main.swift
//  4949
//
//  Created by 조선우 on 2021/01/18.
//
public struct Stack {
    var val: [String]
    
    mutating func push (_ n: String) {
        self.val.append(n)
    }
    mutating func pop () -> String? {
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
    mutating func top () -> String? {
        if self.val.isEmpty {
            return nil
        } else {
            return self.val.last!
        }
    }
}

while true {
    let line = readLine()!
    var ans = "yes"
    if line == "." {
        break
    }
    
    var stack_s = Stack(val: [])
    let lineArr = line.map{String($0)}
    for i in 0 ..< lineArr.count {
        if lineArr[i] == "(" || lineArr[i] == "[" {
            stack_s.push(lineArr[i])
        } else if lineArr[i] == ")" {
            if stack_s.top() == nil || stack_s.top() == "[" {
                ans = "no"
                break
            } else {
                _ = stack_s.pop()
            }
        } else if lineArr[i] == "]" {
            if stack_s.top() == nil || stack_s.top() == "(" {
                ans = "no"
                break
            } else {
                _ = stack_s.pop()
            }
        }
    }
    if !stack_s.empty() {
        ans = "no"
    }
    print(ans)
}
