# LV1

# 완주하지 못한 선수

from collections import Counter

def solution(participant, completion):
    answer = Counter(participant) - Counter(completion)
    return list(answer.keys())[0]


# LV2

#전화번호 목록

def solution(phone_book):
    
    answer = True
    
    temp = sorted(phone_book)
    
    for i in range(0,len(phone_book)-1):
        if len(temp[i]) <= len(temp[i+1]):
            if temp[i] == temp[i+1][0:len(temp[i])]:
                answer = False
                break

    return answer

# 위장

def solution(clothes):
    from collections import Counter
    answer = 1
    
    temp = Counter([i[1] for i in clothes]).values()
    
    for i in temp:
        answer *= (i+1)
        
    return answer - 1