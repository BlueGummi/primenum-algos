use std::sync::atomic::{AtomicBool, Ordering};

static KEEP_RUNNING: AtomicBool = AtomicBool::new(true);


fn is_prime(num: i32) -> bool {
    if num <= 1 {
        return false;
    }
    if num <= 3 {
        return true;
    }
    if num % 2 == 0 || num % 3 == 0 {
        return false;
    }

    let limit = (num as f64).sqrt() as i32;
    let mut i = 5;
    while i <= limit {
        if num % i == 0 || num % (i + 2) == 0 {
            return false;
        }
        i += 6;
    }
    true
}

fn main() {

    let mut number = 2;

    while KEEP_RUNNING.load(Ordering::SeqCst) {
        if is_prime(number) {
            println!("{}", number);
        }
        number += 1;

    }

}
