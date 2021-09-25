//
//  main.swift
//  5430
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

for _ in 0 ..< Int(readLine()!)! {
    let command = readLine()!.map{String($0)}
    let n = Int(readLine()!)!
    let arr = readLine()!.map{String($0)}
    var dq = Deque()
    var flag_r = false
    var flag_e = false
    
    var start = 1
    if n != 0 {
        for i in 1 ... arr.count-2 {
            if arr[i] == "," {
                let x = Int(arr[start...i-1].joined())!
                dq.push_back(i: x)
                start = i+1
            }
        }
        dq.push_back(i: Int(arr[start...arr.count-2].joined())!)
    }
    
    for c in command {
        if c == "R" {
            if flag_r == false {
                flag_r = true
            } else {
                flag_r = false
            }
        } else if c == "D" {
            if dq.empty() == 1 {
                flag_e = true
                break
            } else {
                if flag_r == false {
                    _ = dq.pop_front()
                } else {
                    _ = dq.pop_back()
                }
            }
        } else {
            print("error")
        }
    }
    
    if flag_e {
        print("error")
    } else {
        print("[", separator: "", terminator: "")
        if flag_r {
            if dq.empty() == 0 {
                print(dq.pop_back(), terminator: "")
                while dq.empty() == 0 {
                    print(",", terminator: "")
                    print(dq.pop_back(), terminator: "")
                }
                print("]")
            } else {
                print("]")
            }
        } else {
            if dq.empty() == 0 {
                print(dq.pop_front(), terminator: "")
                while dq.empty() == 0 {
                    print(",", terminator: "")
                    print(dq.pop_front(), terminator: "")
                }
                print("]")
            } else {
                print("]")
            }
        }
    }
}


