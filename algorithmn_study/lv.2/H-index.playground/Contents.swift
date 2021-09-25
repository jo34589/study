import Foundation

func solution(_ citations:[Int]) -> Int {
    // n: 1000, m: 10000
    //찾아야 하는 것: h 의 최댓값
    //h 값이 커질 때 (h 보다 인용수가 많은 원소의 개수)는 nondecreasing
    //정렬되어있다고 볼 수 있음 => 이진탐색 가능
    //찾는 방법: 이진탐색
        //이진탐색 시작: low = 0, high = citations.max() <= h값.
    //이진탐색을 위해 필요한 값: citations 중 h 값인 mid 보다 크거나 같은 원소의 개수
        //인덱스로 찾으려면?
            // citations 가 정렬되어 있다면 이중탐색 nlogn + (logn)*(logm) = nlogn
        // 아니라면 O(n)의 그냥 탐색 => nlogm
        // n logm 채택
    //값이 mid 보다 크거나 같으면? low 를 끌어올림
    //값이 mid 보다 작으면? high 를 끌어내림
    var low = 0
    var high = citations.max()! + 1
    while low < high {
        let mid = (low + high) / 2
        var val = 0
        for i in 0 ..< citations.count {
            if mid <= citations[i] {
                val += 1
            }
        }
        if mid > val {
            high = mid
        } else {
            low = mid + 1
        }
    }
    return high - 1
}

solution([3, 0, 6, 1, 5]) //3
solution([12, 11, 10, 9, 8, 1]) //5
solution([6, 6, 6, 6, 6, 1]) //5
solution([4, 4, 4]) //3
solution([4, 4, 4, 5, 0, 1, 2, 3]) //4
solution([10, 11, 12, 13]) //4
solution([3, 0, 6, 1, 5]) //3
solution([0, 0, 1, 1]) //1
solution([0, 1]) //1
solution([10, 9, 4, 1, 1]) //3
solution([31, 66]) //2
solution([0, 0, 0]) //0
solution([0, 1, 1]) //1
solution([0, 1, 2]) //1
solution([4, 3, 3, 3, 3]) //3
