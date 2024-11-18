function isPrime(num) {
    if (num <= 1) return false;
    for (let i = 2; i <= Math.sqrt(num); i++) {
        if (num % i === 0) return false;
    }
    return true;
}

let count = 0;
function printPrimes() {
    while (true) {
        if (isPrime(count)) {
            console.log(count);
        }
        count++;
    }
}

printPrimes();
