import Foundation

func solution(_ table:[String], _ languages:[String], _ preference:[Int]) -> String {
    var tb = [[String]]()
    var points = [Int](repeating: 0, count: 6)
    var maxi = 0
    var area = [String]()
    for row in table {
        tb.append(row.split(separator: " ").map() {String($0)})
    }
    
    for i in 1 ... 5 {
        let row = tb[i-1]
        //print(row, terminator: " ")
        var point = 0
        for k in 1 ... 5 {
            for j in 0 ..< languages.count {
                if row[k] == languages[j] {
                    point += (6-k) * preference[j]
                }
            }
        }
        //print(point)
        points[i] = point
        if points[i] > points[maxi] {
            maxi = i
        }
    }
    
    for i in 1 ... 5 {
        if points[i] == points[maxi] {
            area.append(tb[i-1][0])
        }
    }
    //print(area)
    
    if area.count > 1 {
        area.sort()
    }
    
    return area[0]
}


print(solution(["SI JAVA JAVASCRIPT SQL PYTHON C#", "CONTENTS JAVASCRIPT JAVA PYTHON SQL C++", "HARDWARE C C++ PYTHON JAVA JAVASCRIPT", "PORTAL JAVA JAVASCRIPT PYTHON KOTLIN PHP", "GAME C++ C# JAVASCRIPT C JAVA"], ["PYTHON", "C++", "SQL"], [7, 5, 5]))
print(solution(["SI JAVA JAVASCRIPT SQL PYTHON C#", "CONTENTS JAVASCRIPT JAVA PYTHON SQL C++", "HARDWARE C C++ PYTHON JAVA JAVASCRIPT", "PORTAL JAVA JAVASCRIPT PYTHON KOTLIN PHP", "GAME C++ C# JAVASCRIPT C JAVA"], ["JAVA", "JAVASCRIPT"], [7, 5]))
