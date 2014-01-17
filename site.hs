{-# LANGUAGE OverloadedStrings #-}
import Hakyll
import qualified Text.Pandoc as Pandoc
import System.Process (runInteractiveProcess, waitForProcess)
import System.FilePath ((</>), takeDirectory, replaceExtension, takeFileName)
import qualified Data.ByteString as B

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

runAndWait :: FilePath -> [String] -> FilePath -> IO ()
runAndWait program args dir = do
    (_inp, _out, _err, pid) <-
      runInteractiveProcess program
                            args
                            (Just dir)
                            Nothing
    waitForProcess pid
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
                 [takeFileName fp]
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
