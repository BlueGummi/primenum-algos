import Control.Monad (forever)
import Control.Concurrent (threadDelay)

isPrime :: Int -> Bool
isPrime n
    | n < 2     = False
    | otherwise = null [ x | x <- [2..isqrt n], n `mod` x == 0]
    where isqrt = floor . sqrt . fromIntegral

primes :: [Int]
primes = filter isPrime [2..]

main :: IO ()
main = forever $ do
    mapM_ print primes
