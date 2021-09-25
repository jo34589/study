import Foundation

func solution(_ n:Int, _ times:[Int]) -> Int64 {
    //중간까지는 맞으나, 시간초과남.
    // => 다른 방법? 최적화?
        //이거 최적화 가능한가. 일단 insert 때문에라도 O(N*m)인 상태.
        //안됨.
    /*
    let times = times.sorted(by: >)
    var endtimes:[[Int64]] = times.map({[Int64($0), Int64($0)]})
    let last_i = times.count - 1
    //print(endtimes)
    for i in 0 ..< n - 1 {
        var lower = 0
        var higher = last_i
        endtimes[last_i][0] += endtimes[last_i][1]
        while lower < higher {
            let mid = (lower + higher) / 2
            let midval = endtimes[mid][0]
            if midval < endtimes[last_i][0] {
                higher = mid
            } else {
                lower = mid + 1
            }
        }
        endtimes.insert(endtimes[last_i], at: lower)
        endtimes.removeLast()
        //print("\(endtimes), \(i)")
    }
    
    return endtimes[last_i][0]
    */
    
    //시간에 최소값, 최대값을 두고, 이분탐색으로 맞는 시간을 찾아가는 방법.
    //이분탐색의 전제 조건은 : 정렬되어있어야 함(감소하지 않는다 or 증가하지 않는다)
        //a시간이 걸리는 창구에서 주어진 시간 n 동안 처리할 수 있는 사람의 숫자는 n/a
        //이는 n 이 커질수록 감소하지 않음
        //그런 종류가 총 m 개, 모두 더한다고 하면: 감소하지 않는 특성은 유지됨.
    //그럼 최소, 최대값 설정해봅시다.
        //이해가 안 되던거 하나 더 있었지.
        //왜 최대값을 처리시간 가장 작은 사람이 n 명 다 처리하는 케이스로 하는거지? 라는거.
            //탐색범위를 줄이기위함
        //최소: 1명처리, 최대 n명 처리
    //거기서 나오는 값이란: 그 시간동안 처리할 수 있는 사람 숫자.
        //값을 구하는 방법: n/a 를 구해 모두 더한다.
    //O(m logn)
    var low:Int64 = Int64(times.min()!)
    var high:Int64 = Int64(times.max()!) * Int64(n)
    
    while low < high {
        let mid = (low + high) / 2
        var ppp:Int64 = 0
        for t in times {
            ppp += mid / Int64(t)
        }
        if n > ppp {
            low = mid + 1
        } else {
            high = mid
        }
    }
    
    return high
}

solution(6, [7, 10])
//테스트 케이스를 몇 개 더 구할 수 있음 좋을텐데.
