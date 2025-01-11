# How to run

## Requirements

- Python 3.12

## Setup

Create a virtual environment and install the dependencies:

```bash
python -m venv .venv

source .venv/bin/activate

pip install -r requirements.txt
```

## Run

For generating the python gRPC code, run:

```bash
./run.sh gen-proto
```

For running the tests escenarios, run:

```bash
./run.sh run
```
