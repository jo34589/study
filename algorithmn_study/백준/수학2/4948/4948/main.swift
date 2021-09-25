//
//  main.swift
//  4948
//
//  Created by 조선우 on 2020/12/28.
//
var prime = [Bool](repeating: true, count: 246913)
prime[0] = false
prime[1] = false

for i in 1 ... 246912 {
    if prime[i] == true {
        var x = i
        while x <= 246912 {
            prime[x] = false
            x += i
        }
        prime[i] = true
    }
}

while true {
    var ans = 0
    let n = Int(readLine()!)!
    if (n == 0) {
        break
    } else {
        for num in n+1 ... n*2 {
            if prime[num] == true {
                ans += 1
            }
        }
    }
    print(ans)
}
