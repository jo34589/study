import Foundation

func solution(_ numbers:[Int], _ target:Int) -> Int {
    //root node 를 0 으로 설정
    //이진트리
    //left 면 더하기, right 면 빼기
    
    //0 번째 인덱스에 루트 노드의 값: 0 삽입
    var num = numbers
    num.insert(0, at: 0)
    let n = num.count
    
    //end = 2^(n+1) - 1
    //최대 20자리: end 의 최댓값: 2^21 - 1 = 2097151, 약 21만
    var end = 2
    for _ in 0 ..< numbers.count {
        end *= 2
    }
    end -= 1
    
    //배열 정의
    //스택에 가깝게 작동하겠지만, 계산할 때 전체를 탐색하므로 배열
    //이 두 배열은 트리를 순회하는 도중 leaf node 까지 도착했을 때 이때까지 지나쳐왔던 node 를 기억하는 용도.
    //num 배열에서 숫자를 꺼내올 때의 index 이자 이진트리의 depth 를 저장
    var arr_depth: [Int] = []
    //짝,홀을 판단하게 해 줄 index 를 저장
    var arr_index: [Int] = []
    
    //방문한 노드인지 확인할 배열
    //true 가 될 조건 1. left, right 가 없는 leaf 를 방문할 경우
    //              2. left, right 를 모두 방문한 후
    //배열크기: bool type: 1byte x 21만: 대략 2MB
    //트리를 순회하며 모든 원소가 false 가 될 것
        // check 의 index 숫자 범위를 통해 node 의 위치를 알 수 있음
        // 0 : root (2^0 - 1 == 2^1 - 2)
        // 1, 2 : 1층 (num[1]) (2^1 - 1 ~ 2^2 - 2)
        // 3 ~ 6 : 2층 (num[2]) (2^2 -1 ~ 2^3 - 2)
        // 7 ~ 14 : 3층 (num[3]) (2^3-1 ~ 2^4 - 2)
        // 15 ~ 30 : 4층 (num[4]) (2^4-1 ~ 2^5 -2)
        // 31 ~ 62 : 5층 (num[5]) (2^5 -1 ~ 2^6 -2)
        // 홀수 면 왼쪽(+), 짝수면 오른쪽(-)으로 판단 가능.
    var check:[Bool] = Array(repeating: true, count:end)
    
    //계산값이 target 일 때 마다 1씩 더해서 리턴할 변수
    var count = 0
    
    //재귀를 이용
    func dfs(ind :Int, depth: Int) {
        //배열로 이진트리를 구축한 경우 index의 연산을 통해 left, right, parent 를 알 수 있음
        let left = ind*2+1
        let right = left+1
        //let parent = ind%2 == 0 ? ind/2-1:ind/2
        
        //자기자신 배열에 저장
        arr_depth.append(depth)
        arr_index.append(ind)
        
        //디버깅용
        //print(arr_index)
        
        //leaf 노드에 도착한 경우.
        if arr_depth.count == n {
            var sum = 0
            for i in 0 ..< n {
                //num에서 찾은 값을 저장된 index 가 짝수냐 홀수냐에 따라 계산
                //짝수면 빼고
                if arr_index[i]%2 == 0 {
                    sum -= num[arr_depth[i]]
                //홀수면 더함
                } else {
                    sum += num[arr_depth[i]]
                }
            }
            //계산결과 타겟과 일치하면 count
            if sum == target {
                count += 1
                //print("count!")
            }
        }
        
        
        //처리순서:
        //왼쪽 방문, 오른쪽 방문, 자기자신
        if left < end {
            //왼쪽
            if check[left] {
                dfs(ind: left, depth: depth+1)
            }
            //arr 에 있는 왼쪽 값 정리
            arr_depth.removeLast()
            arr_index.removeLast()
            //오른쪽
            if check[right] {
                dfs(ind: right, depth: depth+1)
            }
            //arr 에 있는 오른쪽 값 정리
            arr_depth.removeLast()
            arr_index.removeLast()
        }
        //자기자신
        check[ind] = false
        
    }
    
    dfs(ind: 0, depth: 0)
    
    return count
}

solution([1, 1, 1, 1, 1], 3) //5

