# 예상 대진표

def solution(n,a,b):
    
    new_a, new_b = sorted([a,b])
    answer = 0
    
    while new_b != new_a :
        if new_b % 2 == 1 :
            new_b = new_b // 2 + 1
        else:
            new_b /= 2
            
        if new_a % 2 == 1 :
            new_a = new_a // 2 + 1
        else:
            new_a /= 2
        
        answer += 1

    return answer

# 이진 변환 반복하기

def solution(s):
    first = 0
    second = 0
    while s != '1':
        x = [i for i in s if i == '1']
        second += len(s) - len(x)
        s = str(format(len(x),'b'))
        first += 1
    
    return [first, second]

# 점프와 순간 이동

def solution(n):
    ans = 0
    
    while n > 2 :
        if n % 2 == 1:
            ans += 1
        n //= 2 
        
    return ans + 1

# 방문 길이

def solution(dirs):
    
    command = {'U':(0, 1), 'D':(0, -1), 'L':(-1, 0), 'R':(1, 0)}
    road = set()
    now_x, now_y = (0,0)
    
    for i in dirs:
        next_x, next_y = now_x + command[i][0], now_y + command[i][1]
        if -5 <= next_x <= 5 and -5 <= next_y <= 5:
            road.add((now_x, now_y, next_x, next_y))
            road.add((next_x, next_y, now_x, now_y))
            now_x, now_y = next_x, next_y
        
    return len(road) // 2

# 스킬트리

def solution(skill, skill_trees):
    answer = 0

    for skills in skill_trees:
        skill_list = list(skill)

        for s in skills:
            if s in skill:
                if s != skill_list.pop(0):
                    break
        else:
            answer += 1

    return answer

# 2개 이하로 다른 비트

def solution(numbers):
    ii = 0
    total = []
    
    for num in numbers:
        temp_num = list('0' + bin(int(num))[2:])
        replace_one = ''.join(temp_num).rfind('0')
        
        temp_num[replace_one] = '1'
        
        if num % 2 == 1:
            temp_num[replace_one + 1] = '0'
            
        total.append(int(''.join(temp_num),2))

    return total

# 짝지어 제거하기

def solution(s):
    
    temp = []
    
    for i in s:
        if len(temp) == 0:
            temp.append(i)
        elif temp[-1] == i:
            temp.pop()
        else:
            temp.append(i)
    
    return [1 if len(temp) == 0 else 0][0]