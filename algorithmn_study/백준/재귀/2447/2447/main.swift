//
//  main.swift
//  2447
//
//  Created by 조선우 on 2020/12/31.
//

//https://cryptosalamander.tistory.com/38

func star(_ i: Int, _ j: Int, _ n:Int) -> () {
    if ((i/n)%3 == 1 && (j/n)%3 == 1) {
        print(" ", separator: "", terminator: "")
        //비어야 할 곳만 먼저 처리
        //(i/n) 과 star(i,j,n/3)으로
        //가령 n = 9, i = 3, j = 3 일 때를 생각해 보자.
        //처음 호출될 때는 i/n, j/n 모두 0 이고,
        //n/3 이 0 도 아니기 때문에
        //star(3, 3, 9/3) 이다.
        //star(3,3,3)이면 if문에 걸려 " "가 나오게 된다.
        //근데 왜 && 이지?
            //3 이나 4나 5나 모두 /3 하면 1이 되어버린다. 저게 맞다.
    } else {
        if (n / 3) == 0 {
            print("*", separator: "", terminator: "")
            //n을 나누다 못해 1이 되어서야만 * 이 찍힌다.
        } else {
            star(i, j, n/3)
            //입력받은 n을 점점 나눠가며 '재귀적으로' 빈 공간이 아니게 되면 별을 찍는다.
        }
    }
}

let n = Int(readLine()!)!
for i in 0 ..< n {
    for j in 0 ..< n {
        star(i, j, n)
    }
    print("")
}
