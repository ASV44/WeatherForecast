enum Exception: Error {
    case NetworkConnection
    case HTTP(error: Error)
}
