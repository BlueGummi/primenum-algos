#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <signal.h>
#include <math.h>

volatile sig_atomic_t keep_running = 1;

void handle_sigint(int sig) {
    keep_running = 0;
}

static inline bool is_prime(int num) {
    if (num <= 1) return false;
    if (num <= 3) return true;
    if (num % 2 == 0 || num % 3 == 0) return false;

    int limit = (int) __builtin_sqrt(num);
    for (int i = 5; i <= limit; i += 6) {
        if (num % i == 0 || num % (i + 2) == 0) return false;
    }
    return true;
}

int main() {
    signal(SIGINT, handle_sigint);

    int number = 2;

    while (keep_running) {
        if (is_prime(number)) {
            printf("%d\n", number);
        }
        number++;
    }

    return 0;
}
