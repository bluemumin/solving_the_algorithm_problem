# LV1

# 체육복

def solution(n, lost, reserve):

    real_lost = sorted([i for i in lost if i not in reserve])
    real_reserve = sorted([j for j in reserve if j not in lost])
    answer = n - len(real_lost)
    
    for l in real_lost:
        for x in range(-1,2,1):
            if x == 0:
                continue
            if l + x in real_reserve:
                answer += 1
                real_reserve.remove(l + x)
                break

    return answer

# LV2

# 조이스틱
# ord = 문자 유니코드 반환

def solution(name):
    if set(name) == {'A'}:
        return 0

    answer = float('inf')
    for i in range(len(name) // 2): # 반 이상 움직일 필요 없음
        left_moved = name[-i:]+name[:-i]
        right_moved = name[i:]+name[:i]
        print(left_moved,right_moved)
        for n in [left_moved, right_moved[0]+right_moved[:0:-1]]:
            while n and n[-1] == 'A':
                n = n[:-1]

            row_move = i + len(n)-1
            col_move = 0
            for c in map(ord, n):
                col_move += min(c - ord('A'), ord('Z') - c +1)

            answer = min(answer, row_move + col_move)

    return answer

# 큰 수 만들기
# 숫자를 처음부터 넣어보면서, 중간에 이전보다 큰 숫자가 나오면 빼고 교체하는 방식
def solution(number, k):
    answer = []
    
    for i in number:
        while k > 0 and (answer and answer[-1] < i):
            answer.pop()
            k -= 1
        answer.append(i)
        
    return ''.join(answer[:len(answer) - k])

#구명보트

from collections import deque

def solution(people, limit):
    
    answer = 0
    people = sorted(people)
    
    q = deque(people)
    
    while q:
        if len(q) >= 2 :
            if q[0] + q[-1] <= limit:
                q.pop()
                q.popleft()
                answer += 1
            else:
                q.pop()
                answer += 1
        elif len(q) == 1 :
            q.pop()
            answer += 1

    return answer