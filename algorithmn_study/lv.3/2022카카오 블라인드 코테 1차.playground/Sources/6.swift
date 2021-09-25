import Foundation
//둘다 시간초과
func solution1(_ board:[[Int]], _ skill:[[Int]]) -> Int {
    
    //board 한칸당 해당하는 skill 을 걸러내고(filter) 합산한다음 바로 체크하기?
    var c = 0
    for i in 0 ..< board.count {
        for j in 0 ..< board[0].count {
            var degsum = board[i][j]
            let sks = skill.filter({ $0[1] <= i && $0[3] >= i
                && $0[2] <= j && $0[4] >= j
            })
            for k in sks {
                if k[0] == 1 {
                    degsum -= k[5]
                } else {
                    degsum += k[5]
                }
            }
            if degsum > 0 {
                c += 1
            }
        }
    }
    return c
}

func solution2(_ board:[[Int]], _ skill:[[Int]]) -> Int {
    
    var board = board
    //최적화문제.
    //자 skill 에 들어가 있는 걸 하나하나 처리하려니까 오래 걸린다.
    //skill 행 수: 250,000
    //board 크기: 1000 x 1000
    //곱하면? 당연히 터지지.
    //어떻게 줄일 수 있을까.
    
    for line in skill {
        //line[0] 1 이면 공격, 2 이면 회복
        //(1, 2) (3, 4)
        //line[5] 크기
        for i in line[1] ... line[3] {
            for j in line[2] ... line[4] {
                if line[0] == 1 {
                    board[i][j] -= line[5]
                } else {
                    board[i][j] += line[5]
                }
            }
        }
        //for i in 0 ..< board.count {
        //    print(board[i])
        //}
        //print()
    }
    
    //여기서 n^2 는 어쩔 수 없음.
    var c = 0
    for i in 0 ..< board.count {
        for j in 0 ..< board[0].count {
            if board[i][j] > 0 {
                c += 1
            }
        }
    }
    
    return c
}
