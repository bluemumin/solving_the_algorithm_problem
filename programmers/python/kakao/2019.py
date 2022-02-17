# 실패율

def solution(N, stages):
    
    agg ={}
    length = len(stages)
    for i in range(1, N+1):
        if length != 0:
            count = stages.count(i)
            agg[i] = count / length
            length -= count
        else:
            agg[i] = 0
    return sorted(agg, key=lambda x : agg[x], reverse=True)

# 크레인 인형뽑기 게임

def solution(board, moves):
    
    from pandas import DataFrame
    df = DataFrame(board)
    
    final =[]
    answer = 0

    for i in range(len(moves)):
        col_val = moves[i] -1
        try:
            index = df[df[col_val] != 0].index[0]
        except:
            continue
            
        values = df.iloc[index, df.columns[col_val]]
        final.append(values)
        
        while len(final) >= 2:
            if final[-1] == final[-2]:
                answer += 2
                final = final[:-2]
            else:
                break
                
        df.loc[index][df.columns[col_val]] = 0
    
    return answer