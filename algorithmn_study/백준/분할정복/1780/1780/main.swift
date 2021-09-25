//
//  main.swift
//  1780
//
//  Created by 조선우 on 2021/01/26.
//

let n = Int(readLine()!)!
var paper = Array(repeating: Array(repeating: 0, count: n), count: n)
var one = 0; var zero = 0; var mone = 0

for i in 0 ..< n {
    let line = readLine()!.split(separator: " ").map{Int($0)!}
    paper[i] = line
}

func triPaper(_ i: Int, _ j: Int, n: Int) {
    if n == 1 {
        if paper[i][j] == 1 {
            one += 1
        } else if paper[i][j] == -1 {
            mone += 1
        } else {
            zero += 1
        }
    } else {
        var sum = 0
        let window = n/3
        var z_flag = true
        
        for b in 0 ..< 3 {
            for a in 0 ..< 3 {
                for x in i + (window * a) ..< (i + (window * (a+1))) {
                    for y in j + (window * b) ..< (j + (window*(b+1))) {
                        sum += paper[x][y]
                        if paper[x][y] != 0 {
                            z_flag = false
                        }
                    }
                }
            }
        }
        
        if !z_flag {
            if sum == n * n {
                one += 1
            } else if sum == -(n*n) {
                mone += 1
            } else {
                for a in 0 ..< 3 {
                    for b in 0 ..< 3 {
                        triPaper(i+(window*a), j+(window*b), n: n/3)
                    }
                }
            }
        } else {
            zero += 1
        }
    }
}

triPaper(0, 0, n: n)
print(mone)
print(zero)
print(one)
