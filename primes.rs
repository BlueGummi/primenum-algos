use std::sync::atomic::{AtomicBool, Ordering};
use std::arch::x86_64::{_mm_load_sd, _mm_sqrt_sd, _mm_store_sd};

static KEEP_RUNNING: AtomicBool = AtomicBool::new(true);

fn sqrt(num: f64) -> f64 {
    let mut result: f64 = 0.0;

    unsafe {
        let num_xmm = _mm_load_sd(&num);
        let sqrt_xmm = _mm_sqrt_sd(_mm_load_sd(&result), num_xmm);
        _mm_store_sd(&mut result, sqrt_xmm);
    }

    result
}

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

    let limit = sqrt(num as f64) as i32;
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
