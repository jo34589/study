import Foundation

func solution(_ n:Int) -> Int
{
    guard n > 1 else {
        return 1
    }
    if n%2 == 0 {
        return solution(n/2)
    } else {
        return solution(n-1) + 1
    }
}
