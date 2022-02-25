# LV2

#기능개발

def solution(progresses, speeds):
    
    answer = []
    
    for i, j in list(zip(progresses, speeds)):
    
        day, dot = divmod((100 - i), j)
        
        if dot != 0:
            day += 1
            
        answer.append(day)
    
    real = [1]

    for k in range(0,len(answer)-1):
        if answer[k] >= answer[k+1]:
            answer[k+1] = answer[k]
            real[-1] += 1
        else:
            real.append(1)
    
    return real

# 프린터

def solution(priorities, location):
    
    temp = ['a' * i for i in range(1,len(priorities) + 1)]
    answer = temp[location]
    final = []
    
    for i in range(len(priorities)):
        max_index = priorities.index(max(priorities))

        priorities = priorities[max_index:] + priorities[0:max_index]
        temp = temp[max_index:] + temp[0:max_index]
        priorities.pop(0)
        final.append(temp.pop(0))
            
    return final.index(answer) + 1

# 다리를 지나는 트럭

from collections import deque

def solution(bridge_length, weight, truck_weights):
    bridge_weight = 0
    wait = deque(truck_weights)
    bridge = deque([0] * bridge_length)
    answer = 0
    
    while len(wait) or bridge_weight > 0 :
        bridge_weight -= bridge.popleft()
        
        if len(wait) and bridge_weight + wait[0] <= weight:
            new = wait.popleft()
            bridge_weight += new
            bridge.append(new)
        else:
            bridge.append(0)
        
        answer += 1
    return answer

# 주식가격

def solution(prices):
    answer =[0] * len(prices)
    
    for i in range(len(prices)):
        for j in range(i+1, len(prices)):
            if prices[i] <= prices[j]:
                answer[i] += 1
            else:
                answer[i] += 1
                break
    return answer