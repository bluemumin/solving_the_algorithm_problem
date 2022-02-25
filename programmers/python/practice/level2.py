# 124 나라의 숫자

def solution(n):
    if n<=3:
        return '124'[n-1]
    else:
        q, r = divmod(n-1, 3) 
        return solution(q) + '124'[r]

# 가장 큰 정사각형 찾기

def solution(board):
    for row in board: # 정답의 최소값이 0인지 1인지 먼저 판별
        if sum(row):
            answer = 1
            break
    else:
        return 0
    
	# 1행 1열부터 board를 2x2 정사각형으로 탐색하면서 우측 아래 값 최신화
    for i in range(1, len(board)): # 행
        for j in range(1, len(board[0])): # 열
            if board[i-1][j-1] and board[i-1][j] and board[i][j-1] and board[i][j]:
                board[i][j] = min(board[i-1][j-1], board[i-1][j], board[i][j-1]) + 1
                answer = max(answer, board[i][j])
    
    return answer ** 2

# 올바른 괄호

def solution(s): 
    temp = []

    for i in s:
        if i == '(':
            temp.append(i)
        else:
            if temp == []:
                return False
            else:
                temp.pop()
                
    return temp == []

# 다음 큰 숫자

def solution(n):
    
    bin_n = format(n,'b')
    
    sum_n = sum([int(i) for i in bin_n])
    
    while n != 0:
        n += 1
        if sum([int(i) for i in format(n,'b')]) == sum_n:
            return n

# 땅따먹기

def solution(land):
    for i in range(len(land)-1):
        land[i+1][0] = max(land[i][1], land[i][2], land[i][3]) + land[i+1][0]
        land[i+1][1] = max(land[i][0], land[i][2], land[i][3]) + land[i+1][1]
        land[i+1][2] = max(land[i][0], land[i][1], land[i][3]) + land[i+1][2]
        land[i+1][3] = max(land[i][0], land[i][1], land[i][2]) + land[i+1][3]
    
    return max(land[-1])

# 숫자의 표현

def solution(n):
    answer = 0
    for i in range(1,n+1):
        temp = 0
        while temp < n:
            temp += i
            i += 1
        if temp == n:
            answer += 1

    return answer

# 최댓값과 최솟값

def solution(s):
    
    temp = [int(i) for i in s.split(' ')]
        
    return str(min(temp)) + ' ' + str(max(temp))

# 최솟값 만들기

def solution(A,B):
    return sum(i*j for i, j in zip(sorted(A), sorted(B, reverse = True)))

# 피보나치 수

def solution(n):
    temp = [0, 1]
    for i in range(2, n+1):
        temp.append(temp[i-2] + temp[i-1])
        
    return temp[n] % 1234567

# 행렬의 곱셈

def solution(arr1, arr2):
    
    import numpy as np
    temp = np.array(arr1) @ np.array(arr2)
    
    return getattr(temp, "tolist", lambda: value)()

# JadenCase 문자열 만들기

def solution(s):
    
    return " ".join([(i[0].upper() + i[1:].lower()) 
                     if i != '' else "" 
                     for i in s.split(' ')])

# N개의 최소공배수

def solution(arr):
    
    while len(arr) >= 2 :
        
        temp1 = arr.pop(-1)
        temp2 = arr.pop(-1)
        
        check1 = [temp2 * i for i in range(1,temp1+1)]
        check2 = [temp1 * i for i in range(1,temp2+1)]
        
        total = [j for j in check1 if j in check2]
        
        arr.append(total[0])

    return arr[0]