import requests
import json

def get_latest_block():
    """Get latest Bitcoin block"""
    url = "https://blockchain.info/latestblock"
    response = requests.get(url)
    return response.json()

def get_block_details(block_hash):
    """Get block details including transactions"""
    url = f"https://blockchain.info/rawblock/{block_hash}"
    response = requests.get(url)
    return response.json()

def analyze_coinbase_transaction(block_data):
    """Analyze coinbase transaction"""
    
    print("=" * 60)
    print("Coinbase Transaction Analysis")
    print("=" * 60)
    
    # First transaction is always coinbase
    coinbase_tx = block_data['tx'][0]
    
    print(f"\nBlock Height: {block_data['height']}")
    print(f"Block Hash: {block_data['hash']}")
    print(f"Timestamp: {block_data['time']}")
    
    print(f"\nCoinbase Transaction Hash:")
    print(coinbase_tx['hash'])
    
    print(f"\nInputs: {len(coinbase_tx['inputs'])} (always 0 for coinbase)")
    print(f"Outputs: {len(coinbase_tx['out'])}")
    
    # Calculate total reward
    total_output = sum(out['value'] for out in coinbase_tx['out'])
    total_btc = total_output / 100000000  # Convert satoshis to BTC
    
    print(f"\nBlock Reward: {total_btc} BTC")
    
    # Miner address
    if coinbase_tx['out']:
        miner_address = coinbase_tx['out'][0].get('addr', 'N/A')
        print(f"Miner Address: {miner_address}")
    
    return coinbase_tx

def get_miner_stats(miner_address):
    """Get statistics for a miner address"""
    
    print("\n" + "=" * 60)
    print("Miner Statistics")
    print("=" * 60)
    
    url = f"https://blockchain.info/rawaddr/{miner_address}"
    try:
        response = requests.get(url)
        data = response.json()
        
        print(f"\nTotal Transactions: {data['n_tx']}")
        print(f"Total Received: {data['total_received']/100000000} BTC")
        print(f"Final Balance: {data['final_balance']/100000000} BTC")
        
    except Exception as e:
        print(f"Error fetching miner stats: {e}")

def view_transaction_details(tx_hash):
    """View basic transaction details"""
    
    print("\n" + "=" * 60)
    print("Transaction Details")
    print("=" * 60)
    
    url = f"https://blockchain.info/rawtx/{tx_hash}"
    response = requests.get(url)
    tx = response.json()
    
    print(f"\nTransaction Hash: {tx['hash']}")
    print(f"Size: {tx['size']} bytes")
    print(f"Block Height: {tx.get('block_height', 'Unconfirmed')}")
    
    print("\nInputs:")
    for inp in tx['inputs'][:3]:  # Show first 3
        addr = inp['prev_out'].get('addr', 'N/A')
        value = inp['prev_out']['value'] / 100000000
        print(f"  From: {addr} - {value} BTC")
    
    print("\nOutputs:")
    for out in tx['out'][:3]:  # Show first 3
        addr = out.get('addr', 'N/A')
        value = out['value'] / 100000000
        print(f"  To: {addr} - {value} BTC")

if __name__ == "__main__":
    # Get latest block
    latest = get_latest_block()
    print(f"Latest Block Height: {latest['height']}")
    
    # Get block details
    block = get_block_details(latest['hash'])
    
    # Analyze coinbase
    coinbase = analyze_coinbase_transaction(block)