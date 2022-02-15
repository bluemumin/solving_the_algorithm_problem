# 실패율

def solution(N, stages):
    
    agg ={}
    length = len(stages)
    for i in range(1, N+1):
        if length != 0:
            count = stages.count(i)
            agg[i] = count / length
            length -= count
        else:
            agg[i] = 0
    return sorted(agg, key=lambda x : agg[x], reverse=True)