## install solc and web3 packages
## compile .sol file into bytecode file
## initialize ganache client

## Inside python script:
## load compiled .sol file into python
```compiled_sol = solc.load(open('my.sol'))```
```w3 = Web3(Web3.HTTPProvider('http://127.0.0.1:8545'))```

```w3.eth.default_account = "" // some ganache account```
```bytecode = compiled_sol.get_bytecode()```
```abi = json.loads(compiled_sol.get_abi())```
