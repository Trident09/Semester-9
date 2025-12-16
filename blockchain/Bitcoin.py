import requests
import json

def get_block_by_height(height):
    """Get block data by height"""
    url = f"https://blockchain.info/block-height/{height}?format=json"
    response = requests.get(url)
    return response.json()['blocks'][0]

def analyze_block_chain(start_height, num_blocks=5):
    """Analyze blockchain linking"""
    
    print("=" * 70)
    print("Bitcoin Blockchain Analysis")
    print("=" * 70)
    
    blocks = []
    
    for i in range(num_blocks):
        height = start_height - i
        block = get_block_by_height(height)
        blocks.append(block)
        
        print(f"\n{'='*70}")
        print(f"Block #{height}")
        print(f"{'='*70}")
        
        print(f"\nBlock Hash:")
        print(f"  {block['hash']}")
        
        print(f"\nPrevious Block Hash:")
        print(f"  {block['prev_block']}")
        
        print(f"\nMerkle Root:")
        print(f"  {block['mrkl_root']}")
        
        print(f"\nTimestamp: {block['time']}")
        print(f"Transactions: {block['n_tx']}")
        print(f"Block Size: {block['size']} bytes")
        print(f"Difficulty: {block['bits']}")
        print(f"Nonce: {block['nonce']}")
        
        # Verify linkage
        if i > 0:
            if blocks[i-1]['prev_block'] == block['hash']:
                print(f"\n✓ Correctly linked to Block #{height+1}")
            else:
                print(f"\n✗ Linkage broken!")
    
    print(f"\n{'='*70}")
    print("Chain Verification Complete")
    print(f"{'='*70}")

def visualize_chain_connection(start_height, num_blocks=3):
    """Visualize how blocks connect"""
    
    print("\n" + "=" * 70)
    print("Block Chain Connection Visualization")
    print("=" * 70 + "\n")
    
    for i in range(num_blocks):
        height = start_height - i
        block = get_block_by_height(height)
        
        print(f"Block #{height}")
        print(f"Hash: {block['hash'][:16]}...")
        print(f"|")
        print(f"| (prev_block points to)")
        print(f"|")
        print(f"V")
        
        if i < num_blocks - 1:
            next_block = get_block_by_height(height - 1)
            if block['prev_block'] == next_block['hash']:
                print(f"✓ Verified link\n")
            else:
                print(f"✗ Broken link\n")

def demonstrate_immutability():
    """Demonstrate why blockchain is immutable"""
    
    print("\n" + "=" * 70)
    print("Immutability Demonstration")
    print("=" * 70)
    
    print("\nWhy Blockchain Cannot Be Modified:")
    print("-" * 70)
    
    print("\n1. Each block contains hash of previous block")
    print("2. Changing any data in a block changes its hash")
    print("3. This breaks the link to next block")
    print("4. Would need to recalculate ALL subsequent blocks")
    print("5. Requires enormous computational power")
    print("6. Network would reject invalid chain")
    
    print("\nExample:")
    print("-" * 70)
    print("Block 100: hash = ABC123...")
    print("           prev = XYZ789...")
    print("")
    print("Block 101: hash = DEF456...")
    print("           prev = ABC123... ✓ (matches Block 100)")
    print("")
    print("If we modify Block 100:")
    print("Block 100: hash = NEW999... (changed!)")
    print("           prev = XYZ789...")
    print("")
    print("Block 101: hash = DEF456...")
    print("           prev = ABC123... ✗ (no longer matches!)")

if __name__ == "__main__":
    # Get latest block height
    latest = requests.get(
        "https://blockchain.info/latestblock").json()
    current_height = latest['height']
    
    print(f"Current block height: {current_height}")
    
    # Analyze recent blocks
    analyze_block_chain(current_height, num_blocks=3)
    
    # Visualize connections
    visualize_chain_connection(current_height, num_blocks=3)
    
    # Demonstrate immutability
    demonstrate_immutability()