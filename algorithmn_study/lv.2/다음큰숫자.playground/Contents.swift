import Foundation

func solution(_ n:Int) -> Int
{
    var arr:[Int] = []
    var n = n
    while n > 0 {
        arr.append(n%2)
        n /= 2
    }
    print(arr) //[0, 1, 1, 1, 0, 0, 1] 낮은자리 => 높은자리

    //어떻게든 2진수 배열에서 해결할 방법을 찾는다.
        //모두 1이면? 111111 => 1011111
            //가장 위 1 바로 다음 0을 하나 집어넣는다.
        //1 뒤에 모두 0이면?
            //뒤에 0 추가
        //0과 1이 섞여 있으면? 몇 가지 케이스로 정리해보자.
            // 101 : 110, 110: 1001, 1001: 1010, 1010: 1100, 1100: 10001=> 1이 2개: 뒤의 1을 앞으로 한 칸 올린다. 그 칸에 1이 있을 경우 한 자리를 더 올리고 남은 1을 아래로 배치
            // 1011: 1101, 1101: 1110, 1110: 10011, 10011: 10101
        //공통: 1.맨 뒤에 있는 1을 앞으로 한 칸 올려 더한다.
            // 2.받아올림이 일어나 1 숫자가 모자라지면 모자란 만큼 뒤에 채운다.
    
    var answer:Int = 0
    var i = 0
    while arr[i] != 1 {
        i += 1
    }
    var mone_count = 0
    while arr[i] == 1 {
        mone_count += 1
        arr[i] = 0
        i += 1
        guard i != arr.count else {
            break
        }
    }
    if i == arr.count {
        arr[i-1] = 0
        arr.append(1)
    } else {
        arr[i] = 1
    }
    for j in 0 ..< mone_count-1 {
        arr[j] = 1
    }
    print(arr)
    
    var multiplier = 1
    for i in 0 ..< arr.count {
        answer += multiplier*arr[i]
        multiplier *= 2
    }
    
    return answer
}
