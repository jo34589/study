//
//  main.swift
//  4153
//
//  Created by 조선우 on 2020/12/29.
//

while true {
    let str = readLine()!
    if str == "0 0 0" {
        break
    }
    var arr = str.split(separator: " ").map {Int($0)!}
    arr.sort()//오름차순
    //print(arr)
    if arr[0]*arr[0] + arr[1]*arr[1] == arr[2]*arr[2] {
        print("right")
    } else {
        print("wrong")
    }
}
