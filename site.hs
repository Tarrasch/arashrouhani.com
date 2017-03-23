{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
import Hakyll
import qualified Text.Pandoc as Pandoc
import System.Process (runInteractiveProcess, waitForProcess)
import GHC.IO.Handle (Handle)
import System.Process (ProcessHandle)
import System.FilePath ((</>), takeDirectory, replaceExtension, takeFileName)
import qualified Data.ByteString as B
import GHC.IO.Handle (hGetContents)
import Control.Monad (when)
import System.Exit (ExitCode(ExitSuccess, ExitFailure))
import System.FilePath (takeBaseName)

main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route idRoute
        compile compressCssCompiler

    match "font-awesome-4.7.0/**/*" $ do
        route idRoute
        compile copyFileCompiler

    match "bootstrap-3.3.7-dist/**/*" $ do
        route idRoute
        compile copyFileCompiler

    match "templates/*" $ compile templateCompiler

    match "pages/*.md" $ do
        route removeFolderAndMakeHtml
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html"
                                     defaultContext
            >>= relativizeUrls

    match "cv/cv.tex" $ do
        route $ constRoute "cv.pdf"
        compile pdflatex

    match "papers/*" $ do
        route idRoute
        compile copyFileCompiler

    match "presentations/*" $ do
        route idRoute
        compile copyFileCompiler

    match "grades/*" $ do
        route idRoute
        compile copyFileCompiler

-- Inspired from http://yannesposito.com/Scratch/en/blog/Hakyll-setup/
removeFolderAndMakeHtml :: Routes
removeFolderAndMakeHtml = customRoute createIndexRoute
  where
    createIndexRoute (ident :: Hakyll.Identifier) =
       (takeBaseName p ++ ".html") :: String
      where p = toFilePath ident

unixTimeout :: FilePath -> [String] -> Maybe FilePath -> IO (Handle, Handle, Handle, ProcessHandle)
unixTimeout program args mdir =
        runInteractiveProcess program'
                              args'
                              mdir
                              Nothing
  where program' = "timeout"
        args'    = "--kill-after=10s" : "10s" : program : args

indent :: Int -> String -> String
indent x = unlines . map (replicate x ' ' ++) . lines

isDueTimeout :: ExitCode -> Bool
isDueTimeout x = any ((x ==) . ExitFailure) [128+9, 124] -- See `man timeout`

runAndWait :: FilePath -> [String] -> FilePath -> IO ()
runAndWait program args dir = do
    (_inp, out, err, pid) <-
        unixTimeout program
                    args
                    (Just dir)
    exitCode <- waitForProcess pid
    when (isDueTimeout exitCode) $ putStrLn "Program timed out!!!"
    when (exitCode /= ExitSuccess) $ do
      putStrLn $ "Program `" ++ program ++ "` failed!"
      outS <- hGetContents out
      errS <- hGetContents err
      putStrLn $ "Stdout:\n" ++ indent 4 outS
      putStrLn $ "Stderr:\n" ++ indent 4 errS
    return ()

fileCreatorCompiler :: (FilePath -- ^ Path to x
                         -> ( IO (), -- ^ Action to create file
                              FilePath -- ^ Location of final file
                            ))
                       -> Compiler (Item B.ByteString)
fileCreatorCompiler customs = getUnderlying >>=
    \id -> unsafeCompiler $ do
      let fp = toFilePath id
          (customIO, customLocation) = customs fp
      customIO
      contents <- B.readFile customLocation
      return Item{itemIdentifier = id, itemBody = contents}

pdflatex :: Compiler (Item B.ByteString)
pdflatex = fileCreatorCompiler (\fp ->
      (
      runAndWait "pdflatex"
                 ["-interaction=nonstopmode", takeFileName fp]
                 (takeDirectory fp)
      , replaceExtension fp "pdf"))

-- I dont use it for now but lets keep it in case
-- // arash Aug 2016
make :: String -> -- | Target name
        Compiler (Item B.ByteString)
make target = fileCreatorCompiler (\fp ->
    (
    runAndWait "make"
               [target]
               (takeDirectory fp)
    , takeDirectory fp </> target))
