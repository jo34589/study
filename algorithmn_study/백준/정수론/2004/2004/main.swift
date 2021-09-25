//
//  main.swift
//  2004
//
//  Created by 조선우 on 2021/01/16.
//

let n_m = readLine()!.split(separator: " ").map(){Int($0)!}
var n = n_m[0]
var m = n_m[1]
if m > n/2 {
    m = n-m
}
var count_5 = 0
var count_2 = 0
/* 시간초과
for i in stride(from: n, to: n-m, by: -1) {
    var x = i
    while x % 5 == 0 {
        count_5 += 1
        x /= 5
    }
    var y = i
    while y % 2 == 0 {
        count_2 += 1
        y /= 2
    }
}
for i in 1 ... m {
    var x = i
    while x % 5 == 0 {
        count_5 -= 1
        x /= 5
    }
    var y = i
    while y % 2 == 0 {
        count_2 -= 1
        y /= 2
    }
}
print(min(count_2, count_5))
*/

var i = 5
while n / i >= 1 {
    count_5 += n / i
    i *= 5
}
var j = 2
while n / j >= 1 {
    count_2 += n/j
    j *= 2
}

i = 5
while m / i >= 1 {
    count_5 -= m / i
    i *= 5
}
j = 2
while m / j >= 1 {
    count_2 -= m / j
    j *= 2
}

i = 5
while (n-m) / i >= 1 {
    count_5 -= (n-m) / i
    i *= 5
}
j = 2
while (n-m) / j >= 1 {
    count_2 -= (n-m) / j
    j *= 2
}

print(min(count_5, count_2))
