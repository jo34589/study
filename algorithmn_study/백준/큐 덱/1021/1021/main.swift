//
//  main.swift
//  1021
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
    var head: Node<Int>? = nil
    var tail: Node<Int>? = nil
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

let n_m = readLine()!.split(separator: " ").map {Int($0)!}
var arr = readLine()!.split(separator: " ").map {Int($0)!}

var dq = Deque()
var count = 0

for i in 1 ... n_m[0] {
    dq.push_back(i: i)
}

for i in 0 ..< n_m[1] {
    if dq.front() == arr[i] {
        _ = dq.pop_front()
    } else {
        var count_from_front = 0
        var a = dq.head!
        while a.n != arr[i] {
            a = a.next!
            count_from_front += 1
        }
        
        if (dq.size() / 2) >= count_from_front {
            //2
            for _ in 0 ..< count_from_front {
                let temp = dq.pop_front()
                dq.push_back(i: temp)
            }
            count += count_from_front
            _ = dq.pop_front()
            
        } else {
            //3
            for _ in 0 ..< (dq.size() - count_from_front) {
                let temp = dq.pop_back()
                dq.push_front(i: temp)
            }
            count += (dq.size() - count_from_front)
            _ = dq.pop_front()
        }
    }
}

print(count)
