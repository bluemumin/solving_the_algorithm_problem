# LV1

# 모의고사

def solution(answers):
    one = [1,2,3,4,5] * ( int(len(answers)/5) ) + [1,2,3,4,5] [: int(len(answers)%5) ]
    two = [2,1,2,3,2,4,2,5] * ( int(len(answers)/8) ) + [2,1,2,3,2,4,2,5] [: int(len(answers)%8) ]
    three = [3,3,1,1,2,2,4,4,5,5] * ( int(len(answers)/10) ) + [3,3,1,1,2,2,4,4,5,5] [: int(len(answers)%10) ]
    
    one_temp =  sum([1 if i==j else 0 for i,j in zip(answers, one) ])
    two_temp =  sum([1 if i==j else 0 for i,j in zip(answers, two) ])
    three_temp =  sum([1 if i==j else 0 for i,j in zip(answers, three) ])
    
    total = [i+1 if j == max(one_temp, two_temp, three_temp) else 0 
             for i,j in enumerate( [one_temp, two_temp, three_temp] ) ]
    try:
        while True : 
            total.remove(0)
    except ValueError:
        pass
    return total

# LV2

# 소수 찾기

def solution(numbers):
    
    from itertools import permutations
    
    numbers = [str(i) for i in numbers]
    
    temp = []
    answer = 0
    
    for i in range(1, len(numbers) +1):
        temp.extend([''.join(i) for i in list(permutations(numbers,i))])
        
    check = list(set([int(i) for i in temp]))
    
    
    for y in check:
        div_check = []
        if y <= 1:
            div_check.append(i)
            continue
        for i in range(2, y) :
            if y % i == 0 :
                div_check.append(i)
                break
        if len(div_check) >= 1:
            pass
        else:
            answer += 1
        
    return answer

# 카펫 

def solution(brown, red):
    total = brown + red
    
    for i in range(1, total+1):
        if total % i == 0:
            a = total / i
            if a>= i:
                if 2*a + 2*i == brown + 4:
                    return [a,i]