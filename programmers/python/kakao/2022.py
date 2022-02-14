# 신고 결과 받기

def solution(id_list, report, k):
    
    import pandas as pd
    from pandas import DataFrame
    from collections import Counter
    
    id_list = DataFrame(id_list)
    id_list.columns=['alarm']
    
    deny, alarm = [], []
    
    report_unique = list(set(report))    
    for i in range(len(report_unique)):
        one, two = report_unique[i].split(' ')
        deny.append(two)
        alarm.append(one)
        
    name_check = DataFrame([deny, alarm]).T
    name_check.columns = ['deny', 'alarm']
    
    deny_count = DataFrame([Counter(deny)]).T.reset_index()
    deny_count.columns = ['deny', 'count1']    
    
    alarm_alert = pd.merge(name_check, deny_count, how='left', on = 'deny')
    alarm_alert['alarm_count'] = [1 if i>=k else 0 for i in alarm_alert['count1']]
    
    alarm_check = alarm_alert.groupby('alarm')['alarm_count'].sum().reset_index()
    final = pd.merge(id_list, alarm_check, how='left', on='alarm').fillna(0)
    
    return list(final['alarm_count'])