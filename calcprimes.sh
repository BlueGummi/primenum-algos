function du_primes() {
    # Get the file sizes in bytes and sort them in descending order
    sizes=$(du -b primes_made* 2>/dev/null | sort -nr)

    # Check if there are any files
    if [ -z "$sizes" ]; then
        echo "No files found."
        return
    fi

    # Get the largest file size
    largest_size=$(echo "$sizes" | awk 'NR==1 {print $1}')
    
    # Print file sizes and their percentage relative to the largest file
    echo "$sizes" | awk -v largest="$largest_size" '{
        percent = ($1 / largest) * 100;
        printf "%s: %d bytes (%.2f%%)\n", $2, $1, percent;
    }'
}
function do_em_all() {
    # Start a background countdown
    ( 
        for ((i=40; i>0; i--)); do
            echo "Countdown: $i seconds remaining"
            sleep 1
        done
    ) &

    # Store the background process ID
    countdown_pid=$!

    # Run all commands in the background
    {
        timeout 5s ./primescpp > primes_made_by_cpp
    } &

    {
        timeout 5s ./primesc > primes_made_by_c
    } &

    {
        timeout 5s ./primes > primes_made_by_asm
    } &

    {
        timeout 5s python primes.py > primes_made_by_python
    } &

    {
        timeout 5s ./primeshs > primes_made_by_haskell
    } &

    {
        timeout 5s node primes.js > primes_made_by_js
    } &

    {
        timeout 5s ./primesrs > primes_made_by_rust
    } &

    {
        timeout 5s ./primes.sh > primes_made_by_bash
    } &

    # Wait for all background processes to complete
    wait

    # Kill the countdown process after all commands have finished
    kill $countdown_pid 2>/dev/null
}

do_em_all
./find.sh
