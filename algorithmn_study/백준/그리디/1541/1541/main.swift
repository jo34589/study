//
//  main.swift
//  1541
//
//  Created by 조선우 on 2021/01/11.
//

//import Foundation

var arr = readLine()!.map() {String($0)}
var ans = 0
var num_start_index = 0
var num_end_index = 0
var flag = false
for i in 0 ..< arr.count {
    if flag == false {
        if arr[i] == "+" {
            num_end_index = i-1
            ans += Int(arr[num_start_index...num_end_index].joined())!
            num_start_index = i+1
            //print(ans)
        } else if arr[i] == "-" {
            num_end_index = i-1
            ans += Int(arr[num_start_index...num_end_index].joined())!
            num_start_index = i+1
            flag = true
            //print(ans)
        } else {
            continue
        }
    } else if flag == true {
        if arr[i] == "+"  || arr[i] == "-"{
            num_end_index = i-1
            ans -= Int(arr[num_start_index...num_end_index].joined())!
            num_start_index = i+1
            //print(ans)
        } else {
            continue
        }
    }
}

if flag {
    ans -= Int(arr[num_start_index...(arr.count-1)].joined())!
} else {
    ans += Int(arr[num_start_index...(arr.count-1)].joined())!
}

print(ans)
