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