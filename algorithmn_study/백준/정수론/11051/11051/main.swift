//
//  main.swift
//  11051
//
//  Created by 조선우 on 2021/01/14.
//
// 이항 계수를 동적 계획법으로 풀기.

// 나눗셈과 mod 연산 때문에 정확한 값이 나오지 않는다.
// return (bc(n-1, k-1) * n / k) % mod (틀린 코드)

// (n / k) = (n-1 / k-1) + (n-1 / k) 를 이용 //이항계수의 성질

let mod = 10007
let line = readLine()!.split(separator: " ").map {Int($0)!}
var bc = Array(repeating: Array(repeating: 0, count: 1001), count: 1001)
var ans = 0

for n in 0 ... 1000 {
    bc[n][0] = 1
    bc[n][1] = n
    bc[n][n] = 1
}
bc[0][1] = 1
for n in 2 ... 1000 {
    for k in 2 ..< n {
        bc[n][k] = (bc[n-1][k-1] + bc[n-1][k]) % mod
    }
}
ans = bc[line[0]][line[1]]
print(ans)
