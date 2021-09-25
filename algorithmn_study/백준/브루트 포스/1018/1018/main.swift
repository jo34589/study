//
//  main.swift
//  1018
//
//  Created by 조선우 on 2021/01/01.
//

//import Foundation
let w = "WBWBWBWB".map{String($0)}
let b = "BWBWBWBW".map{String($0)}
let board_W =
    [w, b, w, b, w, b, w, b]

let board_B =
    [b, w, b, w, b, w, b, w]

let n_m = readLine()!.split(separator: " ").map {Int($0)!}
var board = Array(repeating: [String](), count: n_m[0])
for i in 0 ..< n_m[0] {
    let s = readLine()!
    board[i] = s.map{String($0)}
}
var count_W = 100
var count_B = 100

for i in 0 ..< (n_m[0] - 7) {
    for j in 0 ..< (n_m[1] - 7) {
        //starting point
        var temp_count_W = 0
        var temp_count_B = 0
        
        for k in 0 ..< 8 {
            for l in 0 ..< 8 {
                if board[i+k][j+l] != board_W[k][l] {
                    
                    temp_count_W += 1
                } else if board[i+k][j+l] != board_B[k][l] {
                    
                    temp_count_B += 1
                }
            }
        }
        if temp_count_W < count_W {
            count_W = temp_count_W
        }
        if temp_count_B < count_B {
            count_B = temp_count_B
        }
    }
}

print(min(count_B, count_W))
