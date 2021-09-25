//그러니까... 실행을 이미 한 거랑
//작업을 처리 중 일 때 대기중인 거랑
//분리를 해야 하지 않을까?
//1 작업을 처리 중 일 때 요청이 들어와서 대기중인 작업들이 생길 것이고
//2 없다면 기다렸다가 가장 먼저 들어온 걸 처리하면 되고
//3 있다면 그 중에서 가장 요청부터 끝날 때 까지의 시간이 짧을 것으로 예상되는 작업을 수행한다.
//4 이 때 대기중인 작업들의 정렬 방식이 힙 인 것.
//5 이 방식으로 대기중인 작업들은 항상 요청부터 처리까지의 시간이 최소인 작업들이 우선적으로 빠지게 됨.
    //5 를 달리 해석하면.
    //대기중인 작업들은 요청시간과 관계없이 작업시간이 최소인 것을이 가장 우선 빠져야 함.
//6 이 때 힙이 만족해야 하는 것? 최소 힙.
//근데 구현 방법을 새로 해야 할 것 같다. 왠지 틀려.
//정말 jobs에서 제거하는 것 말곤 방법이 없나?
//jobs 에서 제거하는 방법으로 구현했을 때 속도가 조금 더 빨라졌고, 결과가 변하진 않았다.
//그럼 무엇 때문에 1~10 까지 6 빼고 틀리는 걸까?

/*
 일단 필요한 증명1 : 두 개의 작업 [a, b] [c, d] 가 대기 중 일 때,
 작업 시간이 가장 짧은 걸 먼저 해야 하는 이유:
 b < d 라고 가정,
 endtime 이 e 라면
 e 시점에서 [a, b] 를 먼저 했을 때: e+b-a + e+b+d-c
 e 시점에서 [c, d] 를 먼저 했을 때: e+d-c + e+d+b-a
 이 두 개를 놓고 보면 2b+d / 2d+b 로 [a, b] 를 먼저 했을 때 d-b 만큼 전체 시간이 줄어듦
 => 작업시간이 짧은 게 최우선
 그럼 여기서
 작업시간이 같지만, 요청시간이 다른 두 작업이 대기중일 땐 어떻게 해야 할까.
 [a, b] [c, b] 이고, a < c 라면
 위의 식대로 봤을 때 우선순위에 차이는 없다.
 
 각 작업에 대해 [작업이 요청되는 시점, 작업의 소요시간]을 담은 2차원 배열 jobs가 매개변수로 주어질 때, 작업의 요청부터 종료까지 걸린 시간의 평균을 가장 줄이는 방법으로 처리하면 평균이 얼마가 되는지 return 하도록 solution 함수를 작성해주세요. (단, 소수점 이하의 수는 버립니다)
 
 하드디스크가 작업을 수행하고 있지 않을 때에는 먼저 요청이 들어온 작업부터 처리합니다.
 */

import Foundation

func solution(_ jobs:[[Int]]) -> Int {
    
    //리턴할 재료
    let n = jobs.count
    var sum = 0
    //보장이 없으므로 요청 시간 순으로 정렬.
    var jobs = jobs.sorted(by: {
        if $0[0] == $1[0] {
            return $0[1] < $1[1]
        } else {
            return $0[0] < $1[0]
        }
    })
    //대기중인 작업들
    var waiting:[[Int]] = []
    //수행중인 작업이 끝날 시간
    var endtime = 0
    
    for _ in 0 ..< n {
            
        var work:[Int] = []
        //대기가 있나없나에 따라 지금 작업할 것을 결정
        if waiting.count == 0 {
            work = jobs.removeFirst()
            endtime = work[0] + work[1]
            sum += work[1]
        } else {
            waiting.sort(by: {$0[1] < $1[1]})
            work = waiting.removeFirst()
            endtime += work[1]
            sum += endtime - work[0]
        }
        
        //밀리게 되는 작업들
        var i = 0
        while i < jobs.count {
            if jobs[i][0] >= endtime-work[1] && jobs[i][0] <= endtime {
                waiting.append(jobs[i])
                jobs.remove(at: i)
            } else {
                i += 1
            }
        }
        
        //print("done: \(work), endtime: \(endtime), sum: \(sum)")
        //print("jobs: \(jobs), waits: \(waiting)")
    }
    
    return sum/n
}

/*
print(solution([[0, 10], [2, 12], [9, 19], [15, 17]]), 25)
print(solution([[0, 3], [1, 9], [2, 6]]), 9)
print(solution([[0, 1]]), 1)
print(solution([[1000, 1000]]), 1000)
print(solution([[0, 1], [0, 1], [0, 1]]), 2)
print(solution([[0, 1], [0, 1], [0, 1], [0, 1]]), 2)
print(solution([[0, 1], [1000, 1000]]), 500)
print(solution([[100, 100], [1000, 1000]]), 550)
print(solution([[10, 10], [30, 10], [50, 2], [51, 2]]), 6)
print(solution([[0, 3], [1, 9], [2, 6], [30, 3]]), 7)
print(solution([[1, 10], [3, 3], [10, 3]]), 9)
print(solution([[0, 10], [4, 10], [5, 11], [15, 2]]), 15)
print(solution([[0, 10]]), 10)
print(solution([[0, 3], [1, 9], [2, 6], [4, 3]]), 9)
print(solution([[0, 1], [1, 2], [500, 6]]), 3)
print(solution([[0, 3], [1, 9], [500, 6]]), 6)
print(solution([[0, 3], [4, 3], [8, 3]]), 3)
print(solution([[0, 3], [4, 3], [10, 3]]), 3)
print(solution([[0, 5], [6, 2], [6, 1]]), 3)
print(solution([[0, 5], [6, 1], [6, 2]]), 3)
print(solution([[0, 5], [2, 2], [5, 3]]), 5)
print(solution([[0, 5], [2, 2], [4, 2]]), 5)
print(solution([[0, 3], [0, 1], [4, 7]]), 4)
print(solution([[0, 2], [3, 6], [3, 1]]), 3)
print(solution([[0, 5], [1, 2], [5, 5]]), 6)
print(solution([[0, 9], [0, 4], [0, 5], [0, 7], [0, 3]]), 13)
print(solution([[24, 10], [28, 39], [43, 20], [37, 5], [47, 22], [20, 47], [15, 2], [15, 34], [35, 43], [26, 1]]), 72)
print(solution([[24, 10], [28, 39], [43, 20], [37, 5], [47, 22], [20, 47], [15, 34], [15, 2], [35, 43], [26, 1]]), 72)
print(solution([[1, 9], [1, 4], [1, 5], [1, 7], [1, 3]]), 13)
*/
