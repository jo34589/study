import Foundation
//들어온 순서 배열 //순서만 알고 타이밍은 모름
//나간 순서 배열 을 주고
//# 번은 최소 ? 명을 만났는지 배열로 리턴
func solution(_ enter:[Int], _ leave:[Int]) -> [Int] {
    var ans = [Int](repeating: 0, count: enter.count+1)
    let n = enter.count
    
    for i in 1 ... n {
        let e = enter.firstIndex(of: i)!
        let l = leave.firstIndex(of: i)!
        if e == 0 && l == 0 {
            ans[i] = 0
        }
        else if e == n-1 && l == n-1 {
            ans[i] == 0
        }
        else {
            var p = n-1
            for ind in 0 ..< l {
                //나보다 먼저 나간 사람들이 입장한 인덱스가 나보다 작다면? => 먼저나갔지 = 안만남.
                if e > enter.firstIndex(of:leave[ind])! {
                    p -= 1
                }
            }
            for ind in l ..< n {
                //나보다 늦게 나간 사람들이 입장한 인덱스가 나보다 크다면? => 늦게들어왔지 = 안만남.
                if e < enter.firstIndex(of: leave[ind])! {
                    p -= 1
                }
            }
            ans[i] = p
        }
    }
    
    ans.removeFirst()
    return ans
}

print(solution([1,4,2,3], [2,1,3,4]))
