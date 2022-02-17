# 신규 아이디 추천

def solution(new_id):
    import re
    
    new_id = new_id.lower() # 1단계
    new_id = re.sub('[^a-z0-9-_.]','',new_id) #2단계
    new_id = re.sub('[.]{2,}','.',new_id) #3단계

    # 4단계
    if new_id[0] == '.' and len(new_id) >=2 :
        new_id = new_id[1:]
    if new_id[-1] == '.':
        new_id = new_id[:-1]
    
    # 5단계
    if len(new_id) == 0 :
        new_id = 'a'
    
    #6단계
    if len(new_id) >= 16:
        new_id = new_id[:15]
        if new_id[-1] == '.':
            new_id = new_id[:-1]
    
    #7단계
    if len(new_id) <= 2:
        temp = new_id[-1]
        while len(new_id) != 3:
            new_id += temp
            
    return new_id