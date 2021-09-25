import Foundation

func solution(_ info:[String], _ query:[String]) -> [Int] {
    
    //n*m 효율성 시간초과
    /*
    var ans:[Int] = []
    for line_q in query {
        var count = 0
        let q = line_q.split(separator: " ").map({String($0)}).filter({$0 != "and"})
        for line_i in info {
            let l = line_i.split(separator: " ").map({String($0)})
            var condition = 0
            if Int(q[4])! <= Int(l[4])! {
                condition += 1
            } else {
                continue
            }
            for i in 0 ..< q.count - 1 {
                if q[i] == "-" || q[i] == l[i] {
                    condition += 1
                } else {
                    break
                }
            }
            if condition == q.count {
                count += 1
            }
        }
        ans.append(count)
    }
    */
    
    //info 받아서 정렬
    // nlogn
    //query 마다 이중탐색으로 위치 발견
    // mlogn 해서 그 위로 쭉 탐색 n
    // mnlogn 놉.
    
    //언어 3가지, 직군 2가지, 경력 2가지, 소울푸드 2가지 의 경우의 수를 세 보면
    //50000 개의 지원서는 모두 3*2*2*2 = 24 즉 24가지로 환원 가능하다
    //24개의 배열을 만들어 각각의 경우에 맞는 점수들을 저장한다.
    //10만개의 info 는 24가지 중 하나 이상을 가리킨다.
    //해당하는 가지들의 배열을 모두 가져온 다음 정렬
    //이진탐색으로 최솟값 인덱스를 찾고
    //전체 - 인덱스 로 계산 한다고 하면
    
    //24가지로 환원시키기: n
    //worst case: n개가 모두 한 가지 안에 들어갈 때
    //m * (n logn + logn)
    
    //아래는 위와 아이디어가 비슷한 카카오 풀이
    //언어 3가지, 직군 2가지, 경력 2가지, 소울푸드 2가지에 각각 '-' 를 더해서
    //모든 지원서는 4*3*3*3=108 가지로 환원 가능하며, 각각의 query 는 반드시 108가지 중 한가지에 대응한다.
        //같은 지원서가 여러 그룹에 들어가 있을 수 있음
    //108가지의 그룹엔 점수가 배열로 들어가 있으며 오름차순으로 정렬되어 있어야 함.
        //이를 위해 info 를 미리 정렬시키고 아래서부터 하나하나씩 집어넣는 방법을 생각할 수 있다.
    //그러면 query 에 해당하는 그룹을 찾아서 그 안에 점수들에 대해 조건에 맞는 지원서의 수를 찾기 위해 이분 탐색을 쓸 수 있다.
    //개수 - 인덱스로 숫자세면 끝.
    //nlogn + n + mlogn
    
    var ans:[Int] = []
    var info = info.map({$0.split(separator: " ").map({String($0)})})
    info.sort(by: {$0[4] <= $1[4]})
    var glist:[[Int]] = Array(repeating: [], count: 108)
    
    
    return ans
}
