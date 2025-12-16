from ecdsa import SigningKey, VerifyingKey, SECP256k1
import hashlib
import binascii

def generate_keys():
    """Generate ECDSA key pair"""
    private_key = SigningKey.generate(curve=SECP256k1)
    public_key = private_key.get_verifying_key()
    
    print("Private Key:", binascii.hexlify(
        private_key.to_string()).decode())
    print("Public Key:", binascii.hexlify(
        public_key.to_string()).decode())
    
    return private_key, public_key

def sign_message(private_key, message):
    """Sign a message"""
    signature = private_key.sign(message.encode())
    print(f"\nMessage: {message}")
    print("Signature:", binascii.hexlify(signature).decode())
    return signature

def verify_signature(public_key, message, signature):
    """Verify signature"""
    try:
        public_key.verify(signature, message.encode())
        print("\nSignature is VALID!")
        return True
    except:
        print("\nSignature is INVALID!")
        return False

if __name__ == "__main__":
    priv, pub = generate_keys()
    msg = "Blockchain transaction"
    sig = sign_message(priv, msg)
    verify_signature(pub, msg, sig)