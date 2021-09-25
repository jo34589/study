//https://programmers.co.kr/learn/courses/30/lessons/60059
//Swift
//이건 무작정 헤딩보단 뭔가 찾아봐야 할 것 같다.
//답: 2차원 행렬 회전시키기

import Foundation

//정사각행렬
//시계방향으로 90도 회전시키기
func rotation_clockwise_90(_ matrix:[[Int]]) -> [[Int]] {
    
    let size = matrix.count
    var mat = matrix
    for i in 0 ..< size {
        for j in 0 ..< size {
            //의외로 간단했다.
            mat[j][size-i-1] = matrix[i][j]
        }
    }
    
    return mat
}
//반시계방향 90도 회전
func rotation_anticlockwise_90(_ matrix:[[Int]]) -> [[Int]] {
    let size = matrix.count
    var mat = matrix
    for i in 0 ..< size {
        for j in 0 ..< size {
            mat[size-j-i][i] = matrix[i][j]
        }
    }
    return mat
}
//가로방향 대칭
func horizontal_mirroring(_ matrix:[[Int]]) -> [[Int]] {
    let size = matrix.count
    var mat = matrix
    for i in 0 ..< size {
        for j in 0 ..< size {
            mat[i][size-j-1] = matrix[i][j]
        }
    }
    return mat
}
//세로방향 대칭
func vertical_mirroring(_ matrix:[[Int]]) -> [[Int]] {
    let size = matrix.count
    var mat = matrix
    for i in 0 ..< size {
        for j in 0 ..< size {
            mat[size-i-1][j] = matrix[i][j]
        }
    }
    return mat
}
//전치(transpose)
func transpose(_ matrix:[[Int]]) -> [[Int]] {
    let size = matrix.count
    var mat = matrix
    for i in 0 ..< size {
        for j in 0 ..< size {
            mat[j][i] = matrix[i][j]
        }
    }
    return mat
}

func solution(_ key:[[Int]], _ lock:[[Int]]) -> Bool {
    
    //lock 을 key 크기만큼 확장
    var key = key
    let key_size = key.count
    let lock_size = lock.count
    var extended_lock = Array(repeating: Array(repeating: 0, count: key_size*2+lock_size-1), count: key_size*2+lock_size-1)
    for i in 0 ..< lock_size {
        for j in 0 ..< lock_size {
            extended_lock[i+key_size-1][j+key_size-1] = lock[i][j]
        }
    }
    //
    //for i in 0 ..< extended_lock.count {
    //    print(extended_lock[i])
    //}
    //
    
    func check(_ matrix: [[Int]]) -> Int {
        var sum = 0
        for i in 0 ..< lock_size {
            for j in 0 ..< lock_size {
                sum += matrix[i+key_size-1][j+key_size-1]
            }
        }
        return sum
    }
    
    for i in 0 ..< extended_lock.count - key_size {
        for j in 0 ..< extended_lock.count - key_size {
            for _ in 0 ..< 4 {
                var temp = extended_lock
                for i_k in 0 ..< key_size {
                    for j_k in 0 ..< key_size {
                        if temp[i+i_k][j+j_k] == 1 && key[i_k][j_k] == 1 {
                            temp[i+i_k][j+j_k] = 0
                        } else {
                            temp[i+i_k][j+j_k] += key[i_k][j_k]
                        }
                    }
                }
                //for i in 0 ..< temp.count {
                //    print(temp[i])
                //}
                //print()
                if check(temp) == lock_size*lock_size {
                    return true
                }
                key = rotation_clockwise_90(key)
            }
        }
    }
    
    return false
}


solution([[0, 0, 0], [1, 0, 0], [0, 1, 1]],    [[1, 1, 1], [1, 1, 0], [1, 0, 1]])//true
