//
//  main.swift
//  18258
//
//  Created by 조선우 on 2021/01/19.
//

public struct Queue {
    private var arr: [Int]
    private var start = 0
    private var end = 0
    init(n:Int) {
        self.arr = Array(repeating: 0, count: n)
    }
    
    mutating func push(n: Int) {
        arr[end] = n
        end += 1
    }
    
    mutating func pop() -> Int {
        if start >= end {
            return -1
        } else {
            let temp = arr[start]
            arr[start] = 0
            start += 1
            return temp
        }
    }
    
    func size() -> Int {
        return (end - start)
    }
    
    func empty() -> Int {
        if self.size() == 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func front() -> Int {
        if self.empty() == 1 {
            return -1
        } else {
            return arr[start]
        }
    }
    
    func back() -> Int {
        if self.empty() == 1 {
            return -1
        } else {
            return arr[end-1]
        }
    }
}


let n = Int(readLine()!)!
var q = Queue(n: n)

for _ in 0 ..< n {
    let line = readLine()!.split(separator: " ").map() {String($0)}
    if line[0] == "push" {
        q.push(n: Int(line[1])!)
    } else if line[0] == "pop" {
        print(q.pop())
    } else if line[0] == "size" {
        print(q.size())
    } else if line[0] == "empty" {
        print(q.empty())
    } else if line[0] == "front" {
        print(q.front())
    } else if line[0] == "back" {
        print(q.back())
    } else {
        print("query error")
    }
}
