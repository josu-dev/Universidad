import pathlib

INPUT = "logs/"
OUTPUT = "logs/report.csv"

def load_csv(file_path: pathlib.Path) -> list[list[str]]:
    with open(file_path, "r") as file:
        return [line.strip().split(",") for line in file]


def main() -> int:
    logs = pathlib.Path(INPUT)
    if not logs.exists():
        print("No se encontraron archivos de logs")
        return 1
    
    csvs = []
    for file in logs.iterdir():
        if not file.is_file():
            continue
        if file.suffix != ".csv":
            continue
        if not file.name.startswith("client") or not file.name[7].isdigit():
            continue

        print(f"Procesando archivo {file.name}")
        csvs.append(load_csv(file)[1:])

    max_len = max(len(csv) for csv in csvs)

    result = [["mensaje"]]
    for i in range(len(csvs)):
        size = 10**(i+1)
        result[0].append(f"buffer {size} 1")
        result[0].append(f"buffer {size} 2")

    for i in range(0,max_len, 2):
        row = [str((i+1) //2 +1)]

        for enu, csv in enumerate(csvs):
            if i < len(csv):
                row.append(csv[i][4])
                row.append(csv[i+1][4])
            else:
                row.append("")
                row.append("")

        result.append(row)

    report = pathlib.Path(OUTPUT)
    with open(report, "w") as file:
        file.writelines(f"{','.join(row)}\n" for row in result)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
