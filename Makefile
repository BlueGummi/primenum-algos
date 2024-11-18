all:
	nasm -f elf64 primes.asm -o primes.o && ld -o primes primes.o && rm primes.o
clean:
	rm -rf primes && rm -rf primes.o
