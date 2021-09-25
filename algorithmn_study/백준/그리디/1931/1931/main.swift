//
//  main.swift
//  1931
//
//  Created by 조선우 on 2021/01/11.
//

//O(N^2) 로 풀면 시간 초과가 난다.
//main idea: 끝나는 시간을 기준으로 정렬한 다음..
//그 중에서 회의 시간이 가장 짧은 걸 집어넣는다.

//import Foundation

let n = Int(readLine()!)!
var conf = Array(repeating: [0, 0], count: n)
for i in 0 ..< n {
    conf[i] = readLine()!.split(separator: " ").map() {Int($0)!}
}

conf.sort() {
    if $0[1] == $1[1] {
        return $0[0] < $1[0]
    } else {
        return $0[1] < $1[1]
    }
}
//반례들로 확인해보니 소팅은 잘 됐다.
//print(conf)
var ans = 0
var last = 0
for dsc in conf {
    if last <= dsc[0] {
        ans += 1
        last = dsc[1]
    }
}
print(ans)
