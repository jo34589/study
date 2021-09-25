//
//  main.swift
//  10757
//
//  Created by 조선우 on 2021/01/06.
//
// 졸라게 큰 수 A + B
// UInt64 로도 모두 담을 수 없다.
// 그렇다면 방법은 한 가지만 남는다.
// 한자리씩 계산하기

var a = Array(repeating: 0, count: 10002)
var b = Array(repeating: 0, count: 10002)
var ans = Array(repeating: 0, count: 10002)

let line = readLine()!.split(separator: " ").map{String($0)}
let line_a = line[0].map{String($0)}
let line_b = line[1].map{String($0)}

for i in 0 ..< line_a.count {
    a[i] = Int(line_a[line_a.count - 1 - i])!
}
for i in 0 ..< line_b.count {
    b[i] = Int(line_b[line_b.count - 1 - i])!
}
var end = max(line_a.count, line_b.count)

for i in 0 ..< end {
    ans[i] += a[i] + b[i]
    if ans[i] >= 10 {
        ans[i+1] += 1
        ans[i] = ans[i] % 10
    }
}

if ans[end] == 0 {
    end -= 1
}

for i in 0 ... end {
    print(ans[end-i], separator: "", terminator: "")
}
print("")
