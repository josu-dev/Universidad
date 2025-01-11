from datetime import datetime

def load_logs(path: str) -> list[list[str]]:
    import csv
    with open(path, encoding='utf-8') as logs_moodle:
        data_logs = csv.reader(logs_moodle, delimiter=',')
        next(data_logs)
        logs = list(data_logs)
    return logs

def date_to_weekday(date: str) -> int:
    date_format = "%d/%m/%Y %H:%M"
    return datetime.strptime(date, date_format).weekday()

def days_difference(first_date:str, last_date:str, date_format:str) -> int:
    difference = datetime.strptime(last_date, date_format).toordinal()\
        - datetime.strptime(first_date, date_format).toordinal()
    return difference


def main():
    # General
    DATE_FORMAT = "%d/%m/%Y %H:%M"
    LOGS_PATH = 'BBB_nuevo.csv'

    logs_recurso = load_logs(LOGS_PATH)

    # 4
    week_days = ('lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo')
    day_counter = {day:0 for day in range(7)}
    for log in logs_recurso:
        day_counter[date_to_weekday(log[0])]+= 1
    activity_summary_ordered = sorted(day_counter.items(), key= lambda x: x[1], reverse=True)
    for day ,cant in activity_summary_ordered[:3]:
        print(f'Dia {week_days[day]}, registros: {cant}')

    # 5
    difference = days_difference(logs_recurso[-1][0], logs_recurso[0][0],DATE_FORMAT)
    print(f'Dias de diferencia: {difference}')


if __name__ == '__main__':
    main()