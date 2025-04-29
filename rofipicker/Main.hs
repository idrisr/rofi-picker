module Main where

import qualified Control.Foldl as Fold
import Data.Text
import Options.Applicative
import System.FilePath
import Turtle

-- figure out sort
getFiles :: FilePath -> Shell FilePath
getFiles file = takeFileName <$> ls file

main :: IO ()
main = do
    Params dir <- cmdLineParser
    sh $ do
        let xs = unsafeTextToLine . pack <$> getFiles dir
        let res = inproc "rofi" (["-sort", "-dmenu", "-multi-select"] :: [Text]) xs
        ff <- fold res Fold.list
        inproc "zathura" (pack . (dir </>) . unpack . lineToText <$> ff) Turtle.empty

newtype Params = Params {directory :: FilePath}
    deriving (Show)

cmdLineParser :: IO Params
cmdLineParser = execParser opts
  where
    opts = info (parseParams <**> helper) (fullDesc <> progDesc "rofi thing")

parseParams :: Parser Params
parseParams = Params <$> strArgument (metavar "<DIR>" <> help "directory")
