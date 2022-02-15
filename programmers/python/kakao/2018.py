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

