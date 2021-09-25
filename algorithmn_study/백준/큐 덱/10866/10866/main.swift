//
//  main.swift
//  10866
//
//  Created by 조선우 on 2021/01/24.
//

public class Node<Value> {
    var n: Value
    var next: Node?
    var prev: Node?
    
    init(n: Value, next: Node? = nil, prev: Node? = nil) {
        self.n = n
        self.next = next
        self.prev = prev
    }
}

public struct Deque {
    private var head: Node<Int>? = nil
    private var tail: Node<Int>? = nil
    private var s = 0
    
    mutating func push_back(i : Int) {
        let a = Node(n: i)
        if s > 0 {
            tail?.next = a
            a.prev = tail
            self.tail = a
            s += 1
        } else {
            self.head = a
            self.tail = a
            s += 1
        }
    }
    
    mutating func push_front(i : Int) {
        let a = Node(n: i)
        if s > 0 {
            head?.prev = a
            a.next = head
            self.head = a
            s += 1
        } else {
            self.head = a
            self.tail = a
            s += 1
        }
    }
    
    func size() -> Int {
        return s
    }
    
    func empty() -> Int {
        if s == 0 {
            return 1
        } else {
            return 0
        }
    }
    
    mutating func pop_back() -> Int {
        if s == 0 {
            return -1
        } else if s > 1 {
            let a = self.tail
            self.tail = a?.prev
            let rtn = a!.n
            s -= 1
            return rtn
        } else if s == 1 {
            let a = self.tail
            let rtn = a!.n
            self.head = nil
            self.tail = nil
            s -= 1
            return rtn
        } else {
            return -1
        }
    }
    
    mutating func pop_front() -> Int {
        if s == 0 {
            return -1
        } else if s > 1 {
            let a = self.head
            self.head = a?.next
            let rtn = a!.n
            s -= 1
            return rtn
        } else if s == 1{
            let a = self.head
            let rtn = a!.n
            self.head = nil
            self.tail = nil
            s -= 1
            return rtn
        } else {
            return -1
        }
    }
    
    func front() -> Int {
        if s == 0 {
            return -1
        } else {
            return self.head!.n
        }
    }
    
    func back() -> Int {
        if s == 0 {
            return -1
        } else {
            return self.tail!.n
        }
    }
}

var dq = Deque()
for _ in 0 ..< Int(readLine()!)! {
    let line = readLine()!.split(separator: " ").map{String($0)}
    if line[0] == "push_back" {
        let n = Int(line[1])!
        dq.push_back(i: n)
    } else if line[0] == "push_front" {
        let n = Int(line[1])!
        dq.push_front(i: n)
    } else if line[0] == "pop_front" {
        print(dq.pop_front())
    } else if line[0] == "pop_back" {
        print(dq.pop_back())
    } else if line[0] == "size" {
        print(dq.size())
    } else if line[0] == "empty" {
        print(dq.empty())
    } else if line[0] == "front" {
        print(dq.front())
    } else if line[0] == "back" {
        print(dq.back())
    } else {
        print("query error")
    }
    
}
