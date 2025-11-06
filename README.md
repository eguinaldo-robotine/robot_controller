python3 -m venv .venv
source .venv/bin/activate

pip install --upgrade pip setuptools wheel
pip install -e .

git clone https://github.com/FAIR-INNOVATION/fairino-python-sdk.git

----- configurar o SDK fairino -----

cd ..

python3 src/main.py