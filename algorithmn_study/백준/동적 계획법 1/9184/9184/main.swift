//
//  main.swift
//  9184
//
//  Created by 조선우 on 2021/01/03.
//

//import Foundation

var w = Array(repeating: Array(repeating: Array(repeating: 0, count: 21), count: 21), count: 21)

w[0][0][0] = 1
for i in 1 ... 20 {
    w[0][0][i] = 1
    w[0][i][0] = 1
    w[i][0][0] = 1
    for j in 1 ... 20 {
        w[0][i][j] = 1
        w[0][j][i] = 1
        w[i][0][j] = 1
        w[j][0][i] = 1
        w[i][j][0] = 1
        w[j][i][0] = 1
    }
}

func fill_w(_ a:Int, _ b:Int, _ c:Int) {
    if a < b && b < c {
        w[a][b][c] = w[a][b][c-1] + w[a][b-1][c-1] - w[a][b-1][c]
    } else {
        w[a][b][c] = w[a-1][b][c] + w[a-1][b-1][c] + w[a-1][b][c-1] - w[a-1][b-1][c-1]
    }
}

func targetindex(of sum:Int) -> [[Int]] {
    var n = 0
    if sum > 20 {
        n = 20
    } else {
        n = sum
    }
    var rtn = [[Int]()]
    for i in 1 ... n {
        for j in 1 ... n {
            for k in 1 ... n {
                if i + j + k == sum {
                    rtn.append([i, j, k])
                }
            }
        }
    }
    _ = rtn.removeFirst()
    return rtn
}

for i in 3 ... 60 {
    for indices in targetindex(of: i) {
        fill_w(indices[0], indices[1], indices[2])
    }
}


while true {
    let input = readLine()!.split(separator: " ").map{Int($0)!}
    if input[0] == -1 && input[1] == -1 && input[2] == -1 {
        break
    } else if input[0] <= 0 || input[1] <= 0 || input[2] <= 0 {
        print("w(\(input[0]), \(input[1]), \(input[2])) = " + "1")
    } else if input[0] > 20 || input[1] > 20 || input[2] > 20 {
        print("w(\(input[0]), \(input[1]), \(input[2])) = \(w[20][20][20])")
    } else {
        print("w(\(input[0]), \(input[1]), \(input[2])) = \(w[input[0]][input[1]][input[2]])")
    }
    
}

