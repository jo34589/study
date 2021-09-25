//
//  main.swift
//  2941
//
//  Created by 조선우 on 2020/12/22.
//

//import Foundation

let word = readLine()!
var count = 0
let arr = word.map({ $0 })
//print(arr) //["l", "j", "e", "s", "=", "n", "j", "a", "k"]

if arr.count == 1 {
    count = 1
} else if arr.count == 2 {
    if arr[1] == "=" {
        if arr[0] == "c" || arr[0] == "s" || arr[0] == "z" {
            count = 1
        } else {
            count = 2
        }
    } else if arr[1] == "-" {
        if arr[0] == "c" || arr[0] == "d" {
            count = 1
        } else {
            count = 2
        }
    } else if arr[1] == "j" {
        if arr[0] == "l" || arr[0] == "n" {
            count = 1
        } else {
            count = 2
        }
    } else {
        count = 2
    }
} else {
    // 3개 이상의 문자가 나올 때. arr.count >= 3
    // 앞 두 칸에 2개의 문자로 이루어진 1개의 알파벳이 나올 경우와 그러지 않을 경우를 처리
    if arr[1] == "=" {
        if arr[0] == "c" || arr[0] == "s" || arr[0] == "z" {
            count = 1
        } else {
            count = 2
        }
    } else if arr[1] == "-" {
        if arr[0] == "c" || arr[0] == "d" {
            count = 1
        } else {
            count = 2
        }
    } else if arr[1] == "j" {
        if arr[0] == "l" || arr[0] == "n" {
            count = 1
        } else {
            count = 2
        }
    } else {
        count = 2
    }
    for i in 2 ..< arr.count {
        count = count + 1
        if arr[i] == "=" {
            if arr[i-1] == "c" || arr[i-1] == "s"{
                count = count - 1
            } else if arr[i-1] == "z" {
                count = count - 1
                if arr[i-2] == "d" {
                    count = count - 1
                } else { continue }
            } else { continue }
        } else if arr[i] == "-" {
            if arr[i-1] == "c" || arr[i-1] == "d" {
                count = count - 1
            } else { continue }
        } else if arr[i] == "j" {
            if arr[i-1] == "n" || arr[i-1] == "l" {
                count = count - 1
            } else { continue }
        } else { continue }
    }
}

print(count)
