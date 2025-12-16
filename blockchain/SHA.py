import hashlib

def demonstrate_sha256():
    """Demonstrate SHA-256 hashing and avalanche effect"""
    
    print("=" * 60)
    print("SHA-256 Hash Demonstration")
    print("=" * 60)
    
    # Original message
    message1 = "Hello, Blockchain!"
    hash1 = hashlib.sha256(message1.encode()).hexdigest()
    
    print(f"\nOriginal Message: {message1}")
    print(f"SHA-256 Hash: {hash1}")
    
    # Slightly modified message (one character change)
    message2 = "Hello, Blockchain."
    hash2 = hashlib.sha256(message2.encode()).hexdigest()
    
    print(f"\nModified Message: {message2}")
    print(f"SHA-256 Hash: {hash2}")
    
    # Compare hashes
    print(f"\nHashes are different: {hash1 != hash2}")
    
    # Calculate difference
    diff_chars = sum(1 for a, b in zip(hash1, hash2) if a != b)
    print(f"Number of different characters: {diff_chars} out of 64")

def demonstrate_sha3():
    """Demonstrate SHA-3 hashing"""
    
    print("\n" + "=" * 60)
    print("SHA-3 Hash Demonstration")
    print("=" * 60)
    
    message = "Blockchain Technology"
    
    # SHA-3 with different bit lengths
    hash_224 = hashlib.sha3_224(message.encode()).hexdigest()
    hash_256 = hashlib.sha3_256(message.encode()).hexdigest()
    hash_384 = hashlib.sha3_384(message.encode()).hexdigest()
    hash_512 = hashlib.sha3_512(message.encode()).hexdigest()
    
    print(f"\nMessage: {message}")
    print(f"\nSHA3-224: {hash_224}")
    print(f"SHA3-256: {hash_256}")
    print(f"SHA3-384: {hash_384}")
    print(f"SHA3-512: {hash_512}")

if __name__ == "__main__":
    demonstrate_sha256()
    demonstrate_sha3()