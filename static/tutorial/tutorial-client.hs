import Control.Monad (replicateM_)
import Data.ByteString.Char8 (pack)
import Network.Socket (withSocketsDo)
import Network.Transport
import Network.Transport.TCP
  (createTransport, defaultTCPAddr, defaultTCPParameters)
import System.Environment (getArgs)

main :: IO ()
main = withSocketsDo $ do
  [host, port, serverAddr] <- getArgs
  Right transport <- createTransport (defaultTCPAddr host port)
                                     defaultTCPParameters
  Right endpoint  <- newEndPoint transport

  let addr = EndPointAddress (pack serverAddr)
  Right conn <- connect endpoint addr ReliableOrdered defaultConnectHints
  _ <- send conn [pack "Hello world"]
  close conn

  replicateM_ 3 $ receive endpoint >>= print

  closeTransport transport
