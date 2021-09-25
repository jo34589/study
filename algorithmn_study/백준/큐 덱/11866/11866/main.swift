//
//  main.swift
//  11866
//
//  Created by 조선우 on 2021/01/23.
//

struct Josep {
    private var arr =  [[Int]()]
    private let k: Int
    private var i = 0
    private var count = 0
    
    init(n:Int, k:Int) {
        self.k = k
        for i in 1 ... n {
            self.arr.append([i, 0])
        }
        arr.removeFirst()
    }
    
    mutating func remove() -> Int {
        for _ in 0 ..< k {
            var n = 0
            while n < arr.count {
                if arr[i][1] == 0 {
                    i += 1
                    i %= arr.count
                    break
                } else {
                    i += 1
                    i %= arr.count
                }
                n += 1
                if n == arr.count {
                    return -1
                }
            }
        }
        if i == 0 {
            i = arr.count - 1
        } else {
            i = i - 1
        }
        arr[i][1] = 1
        return arr[i][0]
    }
}

let n_k = readLine()!.split(separator: " ").map {Int($0)!}
var j = Josep(n: n_k[0], k: n_k[1])
var ans = [Int]()
var a = 0
while a != -1 {
    a = j.remove()
    ans.append(a)
}
ans.removeLast()
let n = ans.count
print("<", separator: "", terminator: "")
for i in 0 ..< (n-1) {
    print("\(ans[i]), ", separator: "", terminator: "")
}
print("\(ans[n-1])>")
