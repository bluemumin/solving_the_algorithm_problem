# LV2

# 타겟 넘버
#BFS 풀이

def solution(numbers, target):
    answer = 0
    leaves = [0]
    for num in numbers:
        tmp = []
        for parent in leaves:
            tmp.append(parent + num)
            tmp.append(parent - num)  
        leaves = tmp
        
    for leaf in leaves:
        if leaf == target:
            answer += 1
        
    return answer