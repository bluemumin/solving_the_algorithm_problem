# 숫자 문자열과 영단어

def solution(s):
    
    num_list = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
    for i, j in enumerate(num_list):
        s = str(i).join(s.split(j))
    return int(s)

# 키패드 누르기

def solution(numbers, hand):
    
    left, right = [3,1], [3,3]
    hand = hand[0].upper()
    numbers = [11 if i ==0 else i for i in numbers]
    answer = []   
    
    for i in range(len(numbers)):
    
        first, second = divmod(numbers[i], 3)

        if second == 0 :
            first -= 1
            second = 3

        if second == 1:
            answer.append('L')
            
        elif second == 3:
            answer.append('R')

        else:
            left_dis = abs(left[0] - first) + abs(left[1] - second)
            right_dis = abs(right[0] - first) + abs(right[1] - second)
            
            if left_dis < right_dis:
                answer.append('L')     
            elif left_dis > right_dis:
                answer.append('R')
            else:
                answer.append(hand)
        
        if answer[-1] == 'L':
            left = [first, second]
        else:
            right = [first, second]
               
    return ''.join(answer)