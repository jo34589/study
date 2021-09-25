//
//  main.swift
//  11653
//
//  Created by 조선우 on 2021/01/06.
//

//풀이 1: 범위 안의 소수를 에라토스테네스의 채로 모두 구해놓고 소인수분해.
//당연하게도 타임아웃이다.
/*
var prime = [Bool](repeating: true, count: 10000001)
prime[0] = false
prime[1] = false

for i in 1 ... 10000000 {
    if prime[i] == true {
        var x = i
        while x <= 10000000 {
            prime[x] = false
            x += i
        }
        prime[i] = true
    }
}

var prime_n = [Int]()

for i in 0 ... 10000000 {
    if prime[i] == true {
        prime_n.append(i)
    }
}

let n = Int(readLine()!)!
var ans = [Int]()
var x = n
var i = 0
while x != 1 {
    if x % prime_n[i] == 0 {
        x /= prime_n[i]
        ans.append(prime_n[i])
        i = 0
    } else {
        i += 1
    }
}

print(prime[4999999])

if n != 1 {
    for a in ans {
        print(a)
    }
}
*/

//풀이2: 그냥 우직하게 가자.
//훨 빠르네...

let n = Int(readLine()!)!
var x = n
var ans = [Int]()
var i = 2
while x != 1 {
    if x % i == 0 {
        ans.append(i)
        x = x / i
        i = 2
    } else {
        i += 1
    }
}

if n != 1 {
    for a in ans {
        print(a)
    }
}
