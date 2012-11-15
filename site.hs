{-# LANGUAGE OverloadedStrings #-}
import Control.Arrow (arr, second, (***), (>>>))
import Hakyll
import qualified Text.Pandoc as Pandoc
import System.Cmd (system)
import System.Process (runInteractiveProcess, waitForProcess)
import System.Directory (getTemporaryDirectory, setCurrentDirectory)
import System.FilePath ((<.>), (</>), takeDirectory, replaceExtension, takeFileName)
import System.IO -- (hPutStr)
import Control.Concurrent -- (forkIO)
import qualified Data.ByteString as B
import qualified Data.Map as M

main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route idRoute
        compile compressCssCompiler

    match "templates/*" $ compile templateCompiler

    let resources =
          [ "software.md"
          , "index.md"
          , "awards-achievements.md"
          , "publications.md"
          ]

    match (list resources) $ do
        route $ setExtension "html"
        compile $ pageCompiler
            >>> applyTemplateCompiler "templates/default.html"
            >>> relativizeUrlsCompiler

    match "external/cv/cv.tex" $ do
        route $ constRoute "cv.pdf"
        compile pdflatex

    match "external/alphabiscuit/report/report.tex" $ do
        route $ constRoute "papers/alphabiscuit.pdf"
        compile pdflatex

pdflatex :: Compiler Resource B.ByteString
pdflatex  = (arr unResource >>>) $ unsafeCompiler $ \fp -> do
    (inp,out,err,pid) <-
      runInteractiveProcess "pdflatex"
                            [takeFileName fp]
                            (Just $ takeDirectory fp)
                            Nothing
    -- forkIO (hPutStrLn inp "X")
    -- forkIO (hGetContents out >>= putStrLn)
    -- forkIO (hGetContents err >>= putStrLn)
    waitForProcess pid
    B.readFile $ replaceExtension fp "pdf"
