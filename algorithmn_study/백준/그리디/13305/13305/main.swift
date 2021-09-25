//
//  main.swift
//  13305
//
//  Created by 조선우 on 2021/01/12.
//

let n = Int(readLine()!)!
let road = readLine()!.split(separator: " ").map() {Int($0)!}
let city = readLine()!.split(separator: " ").map() {Int($0)!}

var mvroad = 0
var maxprice = city[0]
var totalprice = 0

for i in 1 ..< n-1 {
    if city[i] >= maxprice {
        mvroad += road[i-1]
    } else {
        mvroad += road[i-1]
        totalprice += maxprice * mvroad
        maxprice = city[i]
        mvroad = 0
    }
}
mvroad += road[n-2]
totalprice += maxprice * mvroad

print(totalprice)
