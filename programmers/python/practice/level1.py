# 2016년

from datetime import date

def solution(a, b):
    return date(2016,a,b).ctime()[0:3].upper()

# 가운데 글자 가져오기

def solution(s):
    if divmod(len(s),2)[1]==1:
        answer = s[divmod(len(s),2)[0]]
    else:
        answer = s[divmod(len(s),2)[0]-1:divmod(len(s),2)[0]+1 ]
        
    return answer

# 나누어 떨어지는 숫자 배열

def solution(arr, divisor):
    temp = [-1]
    for i in arr:
        if i % divisor==0:
            temp.append(i)
    if len(temp)>=2:
        temp.sort()
        return temp[1:]
    else:
        return temp

# 두 정수 사이의 합

def solution(a, b):
    if a == b:
        return a
    elif a > b:
        return sum(list(range(a, b-1, -1)))
    else:
        return sum(list(range(a, b+1, 1)))

# 문자열 내 마음대로 정렬하기

from operator import itemgetter

def solution(strings, n):
    return sorted( sorted(strings), key=itemgetter(n) ) 

# 문자열 내 p와 y의 개수

def solution(s):
    return s.lower().count('p') == s.lower().count('y')

# 문자열 다루기 기본

def solution(s):
    return s.isdigit() and len(s) in (4, 6)

# 서울에서 김서방 찾기

def solution(seoul):
    return "김서방은 {}에 있다".format(seoul.index('Kim'))

# 소수 찾기

def solution(n):
    num=set(range(2,n+1))

    for i in range(2,n+1):
        if i in num:
            num-=set(range(2*i,n+1,i))
    return len(num)

def solution(n):
    a = [False,False] + [True]*(n-1)
    pr = []
    
    for i in range(2,n+1):
        if a[i]:
            pr.append(i)
            for j in range(2*i,n+1,i):
                a[j] = False
    return len(pr)

# 수박수박수박수박수박수?

def solution(n):
    return "수박"*(n//2) + "수"*(n%2)

# 문자열을 정수로 바꾸기

def solution(s):
    return int(s)

# 시저 암호

import string

def solution(s, n):
    alphabet_lower = list(string.ascii_lowercase)
    alphabet_upper = list(string.ascii_uppercase)
    temp = list(s)
    for i, char in enumerate(temp):
        if char in alphabet_lower:
            position = (alphabet_lower.index(char) + n) % 26
            temp[i] = alphabet_lower[position]
        elif char in alphabet_upper:
            position = (alphabet_upper.index(char) + n) % 26
            temp[i] = alphabet_upper[position]
        else:
            pass
    return ''.join(temp)

# 약수의 합

def solution(num):
    # (해설) num / 2 의 수들만 검사하면 성능 약 2배 향
    return num + sum([i for i in range(1, (num // 2) + 1) if num % i == 0])

def solution(n):
    temp=[]
    for i in range(1, n+1):
        if divmod(n,i)[1] == 0:
            temp.append(i)
    return sum(temp)

# 이상한 문자 만들기

def solution(s):
    new_s = s.split(' ')
    answer = ''
    
    for word in new_s:
        for i, spell in enumerate(word):
            answer += spell.upper() if i % 2 == 0 else spell.lower()
        answer += ' '
    return answer[:-1]

# 자릿수 더하기

def solution(n):
    return sum([int(i) for i in list( str(n) ) ])

# 자연수 뒤집어 배열로 만들기

def solution(n):
    return [int(i) for i in list(str(n))][::-1]

# 정수 내림차순으로 배치하기 #22년 2월 기준 3개 런타임 에러?

def solution(n):
    return int("".join(sorted(list(str(n)), reverse = True)))

#제일 작은 수 제거하기

def solution(arr):
    if len(arr) == 1:
        return [-1]
    else:
        arr.remove(min(arr))
    return arr

# 하샤드 수

def solution(x):
    temp = [int(i) for i in list(str(x))]

    if x % sum(temp) == 0 :
        return True
    else:
        return False

# 핸드폰 번호 가리기

def solution(phone_number):
    return "*" * ( len(phone_number)-4) + phone_number[-4:]

# 행렬의 덧셈

def solution(arr1, arr2):
    for j in range( len(arr1) ):
        for i in range( len(arr1[0]) ):
            arr1[j][i] = arr1[j][i] + arr2[j][i]

    return arr1

# 같은 숫자는 싫어

def solution(s):
    temp = []
    for i in s:
        if temp[-1:] == [i]: 
            continue
        temp.append(i)
    return temp

# 문자열 내림차순으로 배치하기

def solution(s):
    return ''.join(sorted(s, reverse=True))

# 콜라츠 추측

def solution(num):
    answer = 0
    while num != 1:
        if num%2 == 0:
            num = num/2
        else:
            num = 3*num + 1
            
        answer += 1
        if answer >= 500:
            return -1

    return answer

# 평균 구하기

import numpy as np

def solution(arr):
    return np.mean(arr)

# x만큼 간격이 있는 n개의 숫자

def solution(x, n):
    
    if x == 0: #x가 0이고 n이 자연수일때 반환
        return [0]*n
    else: 
        return list(range(x, x*(n+1), x))

# 직사각형 별찍기
a, b = map(int, input().strip().split(' ')) #기본 제공

#return이 아니라 print로 해결해야함
for i in range(b):
    for j in range(a):
        print("*", end='')
    print()

# 최대 공약수와 최소공배수

import math

def solution(n, m):
    return sorted([math.gcd(n,m), math.lcm(n,m)]) #단, 프로그래머스에서는 실행 안됨

def solution(n, m):
    #최소 공배수만 구한 버전
    temp = []
    for i in range(max(n,m), (n*m) + 1):
        if i%n == 0 and i%m ==0:
            temp.append(i)
            break
            
    return sorted([math.gcd(n,m), temp[0]])

# 짝수와 홀수

def solution(num):
    if num % 2 == 1:
        return "Odd"
    else:
        return "Even"

# 정수 제곱근 판별

def solution(n):
    
    if round(n**0.5) == n**0.5:
        return ((n**0.5)+1)**2
    else:
        return -1