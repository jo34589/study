//
//  main.swift
//  1149
//
//  Created by 조선우 on 2021/01/04.
//

//메모라이즈 하는 방법은 정해져 있지 않다!

//기억해야 할 내용: 이전에 어떤 색을 칠했는지 와 그에 따른 최솟값 전체

var min_rgb = Array(repeating: [Int](repeating: 0, count: 3), count: 2)

let t = Int(readLine()!)!
let first = readLine()!.split(separator: " ").map{Int($0)!}

min_rgb[0][0] = first[0]; min_rgb[0][1] = first[1]; min_rgb[0][2] = first[2]

for _ in 0 ... t-2 {
    let new_rgb = readLine()!.split(separator: " ").map {Int($0)!}
    min_rgb[1][0] = new_rgb[0] + min(min_rgb[0][1], min_rgb[0][2])
    min_rgb[1][1] = new_rgb[1] + min(min_rgb[0][0], min_rgb[0][2])
    min_rgb[1][2] = new_rgb[2] + min(min_rgb[0][0], min_rgb[0][1])
    
    //print(min_rgb[1])
    min_rgb[0] = min_rgb[1]
    
}

print(min(min_rgb[0][0], min(min_rgb[0][1], min_rgb[0][2])))
