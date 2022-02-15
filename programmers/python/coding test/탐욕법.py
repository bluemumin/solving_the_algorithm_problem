# 체육복

def solution(n, lost, reserve):

    real_lost = sorted([i for i in lost if i not in reserve])
    real_reserve = sorted([j for j in reserve if j not in lost])
    answer = n - len(real_lost)
    
    for l in real_lost:
        for x in range(-1,2,1):
            if x == 0:
                continue
            if l + x in real_reserve:
                answer += 1
                real_reserve.remove(l + x)
                break

    return answer

    