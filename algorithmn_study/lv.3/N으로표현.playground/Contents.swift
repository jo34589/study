import Foundation

func solution(_ N:Int, _ number:Int) -> Int {
    guard N != number else {
        return 1
    }
    var tower:[[Int]] = [[]]
    tower.append([N])
    tower.append(([N/N, N+N, N*N, N*10+N]))
    for j in 3 ..< 9 {
        var x = 1
        var y = 0
        for _ in 0 ..< j {
            y += x*N
            x*=10
        }
        tower.append([y])
    }
    //print(tower)
    if tower[2].contains(number) {
        return 2
    }
    //3
    for i in 0 ..< tower[2].count {
        tower[3].append(tower[2][i]+tower[1][0])
        tower[3].append(max(tower[1][0]-tower[2][i], tower[2][i]-tower[1][0]))
        tower[3].append(tower[2][i]*tower[1][0])
        tower[3].append(max(tower[1][0]/tower[2][i], tower[2][i]/tower[1][0]))
    }
    if tower[3].contains(number) {
        return 3
    }
    
    //4~8
    for n in 4 ... 8 {
        for i in 1 ... n-1 {
            let j = n - i
            for k in 0 ..< tower[j].count {
                for l in 0 ..< tower[i].count {
                    tower[n].append(tower[i][l] + tower[j][k])
                    if tower[i][l]-tower[j][k] > 0 {
                        tower[n].append(tower[i][l]-tower[j][k])
                    }
                    if tower[j][k]-tower[i][l] > 0 {
                        tower[n].append(tower[j][k]-tower[i][l])
                    }
                    tower[n].append(tower[i][l]*tower[j][k])
                    if tower[j][k] != 0 {
                        tower[n].append(tower[i][l]/tower[j][k])
                    }
                    if tower[i][l] != 0 {
                        tower[n].append(tower[j][k]/tower[i][l])
                    }
                }
            }
        }
        if tower[n].contains(number) {
            return n
        }
    }
    return -1
}
print(solution(5,31168),-1)
/*
print(solution(5,12),4)
print(solution(2,11),3)
print(solution(5,5),1)
print(solution(5,10),2)
print(solution(5,31168),-1)
print(solution(1,1121),7)
print(solution(5,1010),7)
print(solution(3,4),3)
print(solution(5,5555),4)
print(solution(5,5550),5)
print(solution(5,20),3)
print(solution(5,30),3)
print(solution(6,65),4)
print(solution(5,2),3)
print(solution(5,4),3)
print(solution(1,1),1)
print(solution(1,11),2)
print(solution(1,111),3)
print(solution(1,1111),4)
print(solution(1,11111),5)
print(solution(7,7776),6)
print(solution(7,7784),5)
print(solution(2,22222),5)
print(solution(2,22223),7)
print(solution(2,22224),6)
print(solution(2,11111),6)
print(solution(2,11),3)
print(solution(2,111),4)
print(solution(2,1111),5)
print(solution(9,36),4)
print(solution(9,37),6)
print(solution(9,72),3)
print(solution(3,18),3)
print(solution(2,1),2)
print(solution(4,17),4)
*/
