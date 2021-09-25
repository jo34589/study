//
//  main.swift
//  11401
//
//  Created by 조선우 on 2021/01/30.
//
// 1. Binomial(n, k) + Binomial(n, k+1) = Binomial(n+1, k+1) 임을 이용한
// 동적 계획법을 이용한 이항계수 구하기 => O(N^2)지만
// N = 4,000,000 N^2 : 16 * 10^12 당연히 1초 안에는 못 푼다.
// 더 빠른 방법이 필요.
// 2. 페르마의 소정리 를 응용하자.
// Binomial(n, k) = n! / (k! * (n-k)!) 임.
// 페르마의 소정리 란?
// 소수 p 와 정수 a 에 대하여,
// a^p 와 a 를 p 로 나눈 나머지는 같다.
// 여기서 a 가 p 의 배수가 아니라면
// a^(p-1) 과 1 사이에서도 성립한다.
// n! 은 계산하는 데 O(n) 이 걸린다,
// 그러면 1 / (k! * (n-k)!) 를 계산해야 함.
// 이를 소수 p에 대한 (k! * (n-k)!) 의 역원으로 구할 수 있다. <= 이해가 안가짐.
// 역원을 곱하고 p 로 나눴을 때 나머지가 1인 수 로 만들기
// 를 찾으면 된다.
// 페르마의 소정리에 따라 역원을 구하면
// 결국 n! / (k! * (n-k)!) 를 p 로 나눈 나머지는
// n! 를 p 로 나눈 나머지 에다가 (k! * (n-k)!)^(p-2) 를 p 로 나눈 나머지를 곱해서
// p 로 나눈 나머지를 구하는 것과 같다.
// ... 그냥 그렇게 알자...

var fact = Array(repeating: 1, count: 4000001)
func factorial(n: Int, p: Int) {
    if n != 1 {
        for i in 1 ... n {
            fact[i] = (fact[i-1] * i) % p
        }
    }
}

func power(a: Int, b: Int, p: Int) -> Int {
    if b == 0 {
        return 1
    } else if b == 1 {
        return a
    } else {
        var ans = 1
        let temp = power(a: a, b: b/2, p: p) % p
        if b % 2 == 1 {
            ans *= a
        }
        ans *= (temp * temp) % p
        ans %= p
        
        return ans
    }
}

let n_k = readLine()!.split(separator: " ").map() {Int($0)!}
let p = 1000000007
factorial(n: n_k[0], p: p)
let rev = fact[n_k[1]] * fact[n_k[0]-n_k[1]]
let ans = (fact[n_k[0]] * power(a: rev, b: p-2, p: p)) % p

print(ans)
