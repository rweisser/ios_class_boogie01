-- word_count.hs

-- Read a file.  Print an alphabetized list of the words in the file
-- with a count of how many times each word appears in the file.
-- Words are delimited by whitespace.

import Data.Char (toLower)
import qualified Data.Map as M (assocs, empty, insertWith)

main :: IO ()
main = readFile "alice.txt" >>= \contents ->
       mapM_ putStrLn $ process contents

process :: String -> [String]
process = map (\(w, n) -> w ++ ": " ++ show n)
        . M.assocs
        . foldr (\w m -> M.insertWith (+) w 1 m) M.empty
        . concatMap words
        . lines
        . map toLower
