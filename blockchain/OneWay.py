import hashlib
import time
import string
import itertools

def calculate_md5(text):
    """Calculate MD5 hash of given text"""
    return hashlib.md5(text.encode()).hexdigest()

def brute_force_attempt(target_hash, max_length=4):
    """Attempt to brute force MD5 hash"""
    
    print("=" * 60)
    print("Brute Force Reversal Attempt")
    print("=" * 60)
    
    chars = string.ascii_lowercase + string.digits
    attempts = 0
    start_time = time.time()
    
    print(f"\nTarget Hash: {target_hash}")
    print(f"Character set: {chars}")
    print(f"Max length: {max_length}")
    print("\nSearching...\n")
    
    for length in range(1, max_length + 1):
        for combo in itertools.product(chars, repeat=length):
            candidate = ''.join(combo)
            attempts += 1
            
            if calculate_md5(candidate) == target_hash:
                elapsed = time.time() - start_time
                print(f"SUCCESS! Found match: {candidate}")
                print(f"Attempts: {attempts:,}")
                print(f"Time: {elapsed:.2f} seconds")
                return candidate
            
            if attempts % 10000 == 0:
                print(f"Checked {attempts:,} combinations...")
    
    elapsed = time.time() - start_time
    print(f"\nFailed after {attempts:,} attempts")
    print(f"Time taken: {elapsed:.2f} seconds")
    return None

def demonstrate_computational_difficulty():
    """Show why reversing is computationally difficult"""
    
    print("\n" + "=" * 60)
    print("Computational Difficulty Analysis")
    print("=" * 60)
    
    charset_size = 62
    
    print("\nSearch Space Analysis:")
    for length in range(1, 11):
        combinations = charset_size ** length
        print(f"Length {length}: {combinations:,} combinations")
    
    print("\nMD5 produces 2^128 possible outputs")

if __name__ == "__main__":
    simple_text = "cat"
    simple_hash = calculate_md5(simple_text)
    brute_force_attempt(simple_hash, max_length=3)
    demonstrate_computational_difficulty()