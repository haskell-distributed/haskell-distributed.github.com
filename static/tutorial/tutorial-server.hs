import Control.Concurrent (MVar, forkIO, newEmptyMVar, putMVar, readMVar)
import Control.Exception (AsyncException(UserInterrupt), catchJust)
import Data.Map (Map, delete, empty, insert, (!))
import Network.Socket (withSocketsDo)
import Network.Transport
import Network.Transport.TCP
  (createTransport, defaultTCPAddr, defaultTCPParameters)
import System.Environment (getArgs)

main :: IO ()
main = withSocketsDo $ do
  [host, port]    <- getArgs
  serverDone      <- newEmptyMVar
  Right transport <- createTransport (defaultTCPAddr host port)
                                     defaultTCPParameters
  Right endpoint  <- newEndPoint transport
  _ <- forkIO $ echoServer endpoint serverDone
  putStrLn $ "Echo server started at " ++ show (address endpoint)
  readMVar serverDone `onCtrlC` closeTransport transport

-- | Server that echoes messages straight back to the origin endpoint.
echoServer :: EndPoint -> MVar () -> IO ()
echoServer endpoint serverDone = go empty
  where
    go :: Map ConnectionId (MVar Connection) -> IO ()
    go cs = do
      event <- receive endpoint
      case event of
        ConnectionOpened cid rel addr -> do
          connMVar <- newEmptyMVar
          _ <- forkIO $ do
            Right conn <- connect endpoint addr rel defaultConnectHints
            putMVar connMVar conn
          go (insert cid connMVar cs)
        Received cid payload -> do
          _ <- forkIO $ do
            conn <- readMVar (cs ! cid)
            _ <- send conn payload
            return ()
          go cs
        ConnectionClosed cid -> do
          _ <- forkIO $ do
            conn <- readMVar (cs ! cid)
            close conn
          go (delete cid cs)
        EndPointClosed -> do
          putStrLn "Echo server exiting"
          putMVar serverDone ()
        -- ReceivedMulticast and ErrorEvent are not interesting here
        _ -> go cs

onCtrlC :: IO a -> IO () -> IO a
p `onCtrlC` q = catchJust isUserInterrupt p (const $ q >> p `onCtrlC` q)
  where
    isUserInterrupt :: AsyncException -> Maybe ()
    isUserInterrupt UserInterrupt = Just ()
    isUserInterrupt _             = Nothing
