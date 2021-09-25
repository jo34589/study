//
//  main.swift
//  2164
//
//  Created by 조선우 on 2021/01/19.
//

public struct card {
    private var arr: [Int] = []
    private var start = 0
    private var end = n
    init(n:Int) {
        for i in 1 ... n {
            self.arr.append(i)
        }
    }
    
    mutating func movetolast() -> Int? {
        if end - start == 1{
            return nil
        } else {
            start += 1
            arr.append(arr[start])
            end += 1
            start += 1
            return 1
        }
    }
    
    func ans() -> Int {
        return arr[start]
    }
}

let n = Int(readLine()!)!
var q = card(n: n)

//print(q)

var a = q.movetolast()
while a != nil {
    a = q.movetolast()
}

print(q.ans())
