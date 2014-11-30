{-# LANGUAGE OverloadedStrings #-}
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
          , "papers.md"
          , "presentations.md"
          ]

    create resources $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html"
                                     defaultContext
            >>= relativizeUrls

    match "external/cv/cv.tex" $ do
        route $ constRoute "cv.pdf"
        compile pdflatex

    match "external/alphabiscuit/report/report.tex" $ do
        route $ constRoute "papers/alphabiscuit.pdf"
        compile pdflatex

    match "external/rip-final-report/Makefile" $ do
        route $ constRoute "papers/interception.pdf"
        compile $ make "report.pdf"

    match "papers/*" $ do
        route idRoute
        compile copyFileCompiler

    match "presentations/*" $ do
        route idRoute
        compile copyFileCompiler

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

make :: String -> -- | Target name
        Compiler (Item B.ByteString)
make target = fileCreatorCompiler (\fp ->
    (
    runAndWait "make"
               [target]
               (takeDirectory fp)
    , takeDirectory fp </> target))
