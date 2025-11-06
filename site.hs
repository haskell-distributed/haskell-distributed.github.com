{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid (mappend)
import Hakyll
import System.FilePath (takeBaseName, takeDirectory, (</>))

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    -- Copy static files
    match ("img/**" .||. "js/**" .||. "ico/**" .||. "static/**") $ do
        route   idRoute
        compile copyFileCompiler

    -- Copy and compress CSS
    match "css/**" $ do
        route   idRoute
        compile compressCssCompiler

    -- Build tags from posts
    tags <- buildTags "posts/**" (fromCapture "tags/*.html")

    -- Process blog posts
    match "posts/**" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" (postCtxWithTags tags)
            >>= relativizeUrls

    -- Create post list
    create ["blog.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/**"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Blog"                `mappend`
                    constField "page-type" "blog"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/blog.html"    archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls

    -- Process tutorials
    match "tutorials/**" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/tutorial.html" postCtx
            >>= loadAndApplyTemplate "templates/default.html"  defaultContext
            >>= relativizeUrls

    -- Process wiki pages
    match "wiki/**" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/page.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    -- Index page (special handling for hero layout)
    match "index.md" $ do
        route $ setExtension "html"
        compile $ do
            posts <- fmap (take 3) . recentFirst =<< loadAll "posts/**"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "page-type" "home"            `mappend`
                    constField "title" "Home"                `mappend`
                    defaultContext

            pandocCompiler
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/index.html"   indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    -- Other pages (about, contact, documentation, etc.)
    match (fromList ["about.html", "contact.html", "terms.md", "team.md", "wiki.md", "changes.md"]) $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/page.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    -- Documentation page (with sidebar)
    match "documentation.md" $ do
        route $ setExtension "html"
        compile $ do
            let docCtx =
                    constField "page-type" "documentation" `mappend`
                    postCtx

            pandocCompiler
                >>= loadAndApplyTemplate "templates/documentation.html" docCtx
                >>= loadAndApplyTemplate "templates/default.html"      docCtx
                >>= relativizeUrls

    -- Read templates
    match "templates/*" $ compile templateBodyCompiler

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

postCtxWithTags :: Tags -> Context String
postCtxWithTags tags = tagsField "tags" tags `mappend` postCtx
