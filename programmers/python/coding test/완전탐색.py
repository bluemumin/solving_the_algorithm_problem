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

    