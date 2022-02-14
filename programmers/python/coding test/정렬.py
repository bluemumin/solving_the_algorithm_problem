# K번째수

def solution(array, commands):
    answer=[]
    for i in commands:
        t1 = sorted(array [ i[0]-1:i[1] ])
        answer.append( t1[i[2]-1] )
    return answer

    