//
//  main.swift
//  2630
//
//  Created by 조선우 on 2021/01/25.
//

let n = Int(readLine()!)!
var paper = Array(repeating: Array(repeating: 0, count: n), count: n)
var blue = 0
var white = 0

for i in 0 ..< n {
    let line = readLine()!.split(separator: " ").map {Int($0)!}
    paper[i] = line
}

func devide(i: Int, j:Int, n: Int) {
    if n == 1 {
        if paper[i][j] == 1 {
            blue += 1
        } else {
            white += 1
        }
    } else {
        var b1 = 0; var b2 = 0; var b3 = 0; var b4 = 0
        for ix in i ..< i + n/2 {
            for jx in j ..< j + n/2 {
                b1 += paper[ix][jx]
            }
        }
        if b1 == 0 {
            white += 1
        } else if b1 == n * n / 4 {
            blue += 1
        } else {
            devide(i: i, j: j, n: n/2)
        }
        
        for ix in i ..< i + n/2 {
            for jx in (j+n/2) ..< j + n {
                b2 += paper[ix][jx]
            }
        }
        if b2 == 0 {
            white += 1
        } else if b2 == n * n / 4 {
            blue += 1
        } else {
            devide(i: i, j: j+n/2, n: n/2)
        }
        
        for ix in (i + n/2) ..< i + n {
            for jx in j ..< j + n/2 {
                b3 += paper[ix][jx]
            }
        }
        if b3 == 0 {
            white += 1
        } else if b3 == n * n / 4 {
            blue += 1
        } else {
            devide(i: (i+n/2), j: j, n: n/2)
        }
        
        for ix in (i + n/2) ..< i + n {
            for jx in (j + n/2) ..< j + n {
                b4 += paper[ix][jx]
            }
        }
        if b4 == 0 {
            white += 1
        } else if b4 == n * n / 4 {
            blue += 1
        } else {
            devide(i: (i + n/2), j: (j + n/2), n: n/2)
        }
    }
}


devide(i: 0, j: 0, n: n)

print(white)
print(blue)
