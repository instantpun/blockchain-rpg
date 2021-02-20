from web3 import Web3, exceptions

w3 = Web3(Web3.HTTPProvider('http://127.0.0.1:8545'))

print(w3.isConnected())

# firstBlock = w3.eth.get_block(0)
# print(firstBlock)

# thousandBlock = w3.eth.get_block(1000)
# print(thousandBlock)

def iter_blocks(start_block=0):
    counter = start_block
    while True:
        try:
            block = w3.eth.get_block(counter)
            # logs = w3.eth.get_logs()
            # print(block)
            yield block
            counter += 1
            continue
        except exceptions.BlockNotFound as err:
            print("No more blocks")
            break
    return

# logfilter = w3.eth.filter({'fromBlock': 0, 'toBlock': 2})
# # print(logfilter.__dict__)
# print(w3.eth.getFilterLogs(logfilter.filter_id))

# logfilter2 = w3.eth.filter({'fromBlock': 'pending', 'toBlock': 'pending'})
# # print(logfilter.__dict__)
# print(w3.eth.getFilterLogs(logfilter2.filter_id))