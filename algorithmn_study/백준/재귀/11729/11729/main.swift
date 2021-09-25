//
//  main.swift
//  11729
//
//  Created by 조선우 on 2021/01/01.
//

//import Foundation

var count:Int = 0
var ans = [[Int]()]

func hanoi(_ start:Int, _ end: Int, _ n: Int) {
    if n == 1 {
        count += 1
        ans.append([start, end])
    } else {
        var leftover = 0
        if ((start == 1 && end == 2) || (start == 2 && end == 1)) {
            leftover = 3
        } else if ((start == 2 && end == 3) || (start == 3 && end == 2)) {
            leftover = 1
        } else if ((start == 3 && end == 1) || (start == 1 && end == 3)) {
            leftover = 2
        }
        hanoi(start, leftover, n-1)
        hanoi(start, end, 1)
        hanoi(leftover, end, n-1)
    }
}

let n = Int(readLine()!)!
hanoi(1, 3, n)
print(count)
_ = ans.removeFirst()
for a in ans {
    print(a[0], separator: "", terminator: " ")
    print(a[1])
}

