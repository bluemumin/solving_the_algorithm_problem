# LV1

# K번째수

def solution(array, commands):
    answer=[]
    for i in commands:
        t1 = sorted(array [ i[0]-1:i[1] ])
        answer.append( t1[i[2]-1] )
    return answer

# LV2 

# 가장 큰 수

def solution(numbers):
    answer = []
    
    for i in range(9,-1,-1):

        temp = [str(y) for y in numbers if str(y)[0] == str(i)]

        if len(temp) == 0:
            continue
        
        temp.sort(key=lambda x: x*3, reverse=True)
    
        answer.extend(temp)
        
    return str(int(''.join(answer)))

# H-Index
# 예시용 case : [3, 4, 5, 11, 15, 16, 17, 18, 19, 20]의 경우 H-Index는 7

def solution(citations):
    
    sort_rev = sorted(citations, reverse = True)
    
    for i, j in enumerate(sort_rev):
        if i >= j:
            return i    
    return len(sort_rev)