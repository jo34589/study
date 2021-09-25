//
//  main.swift
//  1157
//
//  Created by 조선우 on 2020/12/21.
//

import Foundation

var word = readLine()!
word = word.uppercased()
var ansdict = [String : Int]()
var count = -1
var ans:String = ""
var flag = false

for character in word {
    let c = String(character)
    if ansdict[c] == nil {
        ansdict[c] = 1
    } else {
        ansdict[c] = ansdict[c]! + 1
    }
}
var sorteddict = ansdict.sorted { $0.1 > $1.1 }

if sorteddict.count == 1 {
    ans = sorteddict[0].key
} else {
    if sorteddict[0].value == sorteddict[1].value {
        ans = "?"
    } else {
        ans = sorteddict[0].key
    }
}
print(ans)
