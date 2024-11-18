def is_prime(n):
    if n <= 1:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True

def generate_primes():
    num = 2
    while True:
        if is_prime(num):
            print(num)
        num += 1

try:
    generate_primes()
except KeyboardInterrupt:
    print("\nProgram terminated by user.")
