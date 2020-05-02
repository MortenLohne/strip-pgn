import Data.List
import Data.Char

import System.Environment

main :: IO ()
main = do
  args <- getArgs
  input <- getContents
  case args of
    ["--help"] ->
      putStrLn "usage: strip-pgn {--strip-comments|--move-list|--move-strings| }"
    [] ->
      putStrLn $ strip_comments input
    ["--strip-comments"] ->
      putStrLn $ strip_comments input
    ["--move-list"] ->
      (putStrLn . unwords . words . strip_move_nums . strip_tags . strip_comments) input
    ["--move-strings"] ->
      (putStrLn . unwords . words . add_quotation_marks . strip_move_nums . strip_tags . strip_comments) input
    _:_:_ ->
      putStrLn $ "Multiple arguments are not allowed."
    s:_ ->
      putStrLn $ "Unknown argument " ++ s
    

strip_comments :: String -> String
strip_comments [] = []
strip_comments ('{':xs) = strip_comments (tail $ dropWhile (/= '}') xs)
strip_comments (x:xs) = x:strip_comments xs

strip_tags :: String -> String
strip_tags [] = []
strip_tags ('[':xs) = strip_tags (tail $ dropWhile (/= ']') xs)
strip_tags (x:xs) = x:strip_tags xs

strip_move_nums :: String -> String
strip_move_nums [] = []
strip_move_nums (x:'.':xs) | isDigit x = strip_move_nums xs
strip_move_nums (x:y:'.':xs) | all isDigit [x, y] = strip_move_nums xs
strip_move_nums (x:y:z:'.':xs) | all isDigit [x, y, z] = strip_move_nums xs
strip_move_nums ('.':'.':xs) = strip_move_nums xs
strip_move_nums (x:xs) = x:strip_move_nums xs

add_quotation_marks :: String -> String
add_quotation_marks = intercalate ", " . map ((++ "\"") . ("\"" ++)) . words
