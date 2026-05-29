{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_batalha_naval (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/laersonneto/battleship/batalha-naval/.stack-work/install/aarch64-osx/91d5058e194bea9d121f1a1a9f2613917b7029b3e019c0be39a62664775303ea/9.10.3/bin"
libdir     = "/Users/laersonneto/battleship/batalha-naval/.stack-work/install/aarch64-osx/91d5058e194bea9d121f1a1a9f2613917b7029b3e019c0be39a62664775303ea/9.10.3/lib/aarch64-osx-ghc-9.10.3-fe9c/batalha-naval-0.1.0.0-2vJPnV2GMYDEu0yZk0oiNj-batalha-naval"
dynlibdir  = "/Users/laersonneto/battleship/batalha-naval/.stack-work/install/aarch64-osx/91d5058e194bea9d121f1a1a9f2613917b7029b3e019c0be39a62664775303ea/9.10.3/lib/aarch64-osx-ghc-9.10.3-fe9c"
datadir    = "/Users/laersonneto/battleship/batalha-naval/.stack-work/install/aarch64-osx/91d5058e194bea9d121f1a1a9f2613917b7029b3e019c0be39a62664775303ea/9.10.3/share/aarch64-osx-ghc-9.10.3-fe9c/batalha-naval-0.1.0.0"
libexecdir = "/Users/laersonneto/battleship/batalha-naval/.stack-work/install/aarch64-osx/91d5058e194bea9d121f1a1a9f2613917b7029b3e019c0be39a62664775303ea/9.10.3/libexec/aarch64-osx-ghc-9.10.3-fe9c/batalha-naval-0.1.0.0"
sysconfdir = "/Users/laersonneto/battleship/batalha-naval/.stack-work/install/aarch64-osx/91d5058e194bea9d121f1a1a9f2613917b7029b3e019c0be39a62664775303ea/9.10.3/etc"

getBinDir     = catchIO (getEnv "batalha_naval_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "batalha_naval_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "batalha_naval_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "batalha_naval_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "batalha_naval_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "batalha_naval_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
