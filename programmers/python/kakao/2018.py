# LV1

# [1차] 비밀지도

def solution(n, arr1, arr2):
    
    agg = {}
    
    for y, (t, k) in enumerate(list(zip(arr1, arr2))):
        temp1, temp2 = [], []
        for j in range(n-1,-1,-1):
            
            if t // (2**j) >= 1:
                temp1.append(1)
                t -= (2**j)
            else:
                temp1.append(0) 
                
            if k // (2**j) >= 1:
                temp2.append(1)
                k -= (2**j)
            else:
                temp2.append(0)
                
        agg[y] = [i + j for i,j in list(zip(temp1, temp2))]

    
    total = []
    for i in range(len(agg)):
        temp =[]
        for j in agg[i]:
            if j>=1:
                temp.append('#')
            else:
                temp.append(' ')
        total.append(''.join(temp))
        
    return total

# [1차] 다트 게임

def solution(dartResult):
    
    import re
    
    answer = 0
    num = re.compile('\d{1,}')
    lan = re.compile('[^\d]{1,}')
    
    find_num = num.findall(dartResult)
    find_lan = lan.findall(dartResult)
    
    plus_minus = []
    temp_num = [1,1,1]
    
    for i in range(len(find_lan)):
        if len(find_lan[i]) == 2 :
            plus_minus.append(find_lan[i][-1])
        else:
            plus_minus.append('')
    
    for i in range(len(plus_minus)):
        if i >= 1 and plus_minus[i] == '*':
            temp_num[i-1] *= 2
            temp_num[i] *= 2
        if i == 0 and plus_minus[i] == '*':
            temp_num[i] *= 2
        if plus_minus[i] == '#':
            temp_num[i] *= -1  
            
    dict = {'S' : 1, 'D' : 2, 'T' : 3}
    
    for j in range(0,3):
         answer += (int(find_num[j]) ** dict[find_lan[j][0]]) * temp_num[j]
    
    return answer

# LV2

# [1차] 뉴스 클러스터링

def solution(str1, str2):
    
    from collections import Counter
    import re
    check = re.compile('[a-z]{2}')

    low_str1 = str1.lower()
    low_str2 = str2.lower()
    
    two1 = [low_str1[i] + low_str1[i+1] for i in range(0,len(low_str1)-1)]
    two2 = [low_str2[i] + low_str2[i+1] for i in range(0,len(low_str2)-1)]
    
    final1 = [i for i in two1 if check.findall(i) != []]
    final2 = [i for i in two2 if check.findall(i) != []]
    
    Counter1 = Counter(final1)
    Counter2 = Counter(final2)
    
    inter = list((Counter1 & Counter2).elements())
    union = list((Counter1 | Counter2).elements())
    
    if len(union) == 0 and len(inter) == 0:
        return 65536
    else:
        return int(len(inter)/len(union) * 65536)

#영어 끝말잇기

def solution(n, words):

    for i in range(1,len(words)):
        if (len(words[i]) == 1) or (words[i][0] != words[i-1][-1])  or (words[i] in words[:i]) :
            return [(i%n)+1, (i//n)+1]
        
    else:
        return [0,0]