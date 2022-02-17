# 로또의 최고 순위와 최저 순위

def solution(lottos, win_nums ):
    
    match = len([i for i in lottos if i in win_nums])
    zero = len([i for i in lottos if i in [0]])
    
    first = 7 - (match + zero)
    second = 7 - match
    
    if first >= 6:
        first = 6    
    if second >= 6:
        second = 6
        
    answer = sorted([first, second])

    return answer

# 내적

def solution(a, b):
    return sum([i*j for i,j in list(zip(a, b))])

# 3진법 뒤집기

def solution(n):
    
    answer = 0
    check = 0
    temp = []
    
    for i in range(20,-1,-1):
        if n < 3**i :
            if check != 0 :
                temp.append(0)
            continue
        else:
            check += 1
            temp.append(n // (3**i))
            n = n % (3**i)
            
    for i,j in enumerate(temp):
        print(i,j)
        answer += ((3**i) * j)
    
    return answer

# 두 개 뽑아서 더하기

def solution(numbers):
    answer = []
    numbers_copy = numbers.copy()

    for i in range(len(numbers)):
        temp = numbers.pop(i)
        for j in numbers:
            answer.append(temp + j)
        numbers = numbers_copy.copy()
    
    return sorted(list(set(answer)))

# 음양 더하기

def solution(absolutes, signs):
    answer = 0
    for i, j in list(zip(absolutes, signs)):
        if j == False:
            answer -= i
        else:
            answer += i
            
    return answer

# 약수의 개수와 덧셈

def solution(left, right):
    answer = 0
    
    for num in range(left, right +1):
        temp = 0
        for i in range(1, num+1):
            if num % i == 0:
                temp += 1
        if temp % 2 == 0:
            answer += num
        else:
            answer -= num
            
    return answer


# 없는 숫자 더하기

def solution(numbers):
    answer = 0
    for i in range(1,10):
        if i not in numbers:
            answer += i
    return answer

# 나머지가 1이 되는 수 찾기

def solution(n):
    
    for i in range(1,n+1):
        if n % i == 1:
            return i

# 소수 만들기

def solution(nums):
    from itertools import combinations
    new = []

    for i in combinations(nums, 3):
        new.append(i)

    sum_list = list(map(lambda x: x[0] + x[1] + x[2], new))
    
    answer = 0
    for y in sum_list:
        temp2 = []
        for check in range(1, y+1):
            if y % check == 0:
                temp2.append(check)
        if len(temp2) == 2:
            answer += 1

    return answer

# 예산

def solution(d, budget):
    
    sort_d = sorted(d)
    
    answer = 0
    for i in sort_d:
        budget -= i
        if budget < 0:
            break
        answer += 1
    return answer

# 최소직사각형

def solution(sizes):
    total = []
    for i in sizes:
        total.append(i[0])
        total.append(i[1])
    total = sorted(total)
    
    one = max(total)
    second = min(total)
    
    for i in sizes:
        if i[0] >= second and i[1] >= second:
            second = min(i)
            
    return one * second

# 부족한 금액 계산하기

def solution(price, money, count):
    total = 0
    for i in range(1,count+1):
        total += price * i
        
    if money - total >= 0 :
        return 0
    else:
        return abs(money - total)

# 폰켓몬

def solution(nums):
    return min(len(nums) // 2, len(list(set(nums))))