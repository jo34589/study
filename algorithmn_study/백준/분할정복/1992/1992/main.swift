//
//  main.swift
//  1992
//
//  Created by 조선우 on 2021/01/25.
//

let n = Int(readLine()!)!
var screen = Array(repeating: Array(repeating: 0, count: n), count: n)

for i in 0 ..< n {
    let line = readLine()!.map{Int(String($0))!}
    screen[i] = line
}

func quodTree(_ i: Int, _ j: Int, n: Int) {
    var sum = 0; var p1 = 0; var p2 = 0; var p3 = 0; var p4 = 0
    for x in i ..< (i + n/2) {
        for y in j ..< (j + n/2) {
            sum += screen[x][y]
            p1 += screen[x][y]
        }
    }
    
    for x in i ..< (i + n/2) {
        for y in (j + n/2) ..< (j + n) {
            sum += screen[x][y]
            p2 += screen[x][y]
        }
    }
    
    for x in (i + n/2) ..< (i + n) {
        for y in j ..< (j + n/2) {
            sum += screen[x][y]
            p3 += screen[x][y]
        }
    }
    
    for x in (i + n/2) ..< (i + n) {
        for y in (j + n/2) ..< (j + n) {
            sum += screen[x][y]
            p4 += screen[x][y]
        }
    }
    
    if sum == 0 {
        print("0", terminator: "")
    } else if sum == n*n {
        print("1", terminator: "")
    } else {
        print("(", terminator: "")
        if p1 == n * n / 4 {
            print("1", terminator: "")
        } else if p1 == 0 {
            print("0", terminator: "")
        } else {
            quodTree(i, j, n: n/2)
        }
        
        if p2 == n * n / 4 {
            print("1", terminator: "")
        } else if p2 == 0 {
            print("0", terminator: "")
        } else {
            quodTree(i, (j + n/2), n: n/2)
        }
        
        if p3 == n * n / 4 {
            print("1", terminator: "")
        } else if p3 == 0 {
            print("0", terminator: "")
        } else {
            quodTree((i + n/2), j, n: n/2)
        }
        
        if p4 == n * n / 4 {
            print("1", terminator: "")
        } else if p4 == 0 {
            print("0", terminator: "")
        } else {
            quodTree((i + n/2), (j + n/2), n: n/2)
        }
        print(")", terminator: "")
    }
}

quodTree(0, 0, n: n)
