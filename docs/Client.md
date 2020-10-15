# Client

### Base

1. Use `faraday` as HTTP client
1. Prepare basic call of `REST` and `GraphQL` in `BaseClient`
1. Save credentials in `Rails.application.credentials`

### Client

1. Name by external service (e.g. `UserClient` for `user-service`)
1. Use `dig` and `slice` to sanitize result for simple response
1. Use custom response handler for complicated response

### Test

1. Use `vcr` to record cassette in client specs
1. Assert matching by `path`, `query` and `body` (`header` if any)
1. Remove credentials in cassette
1. Group cassettes by external service
1. Name by error reason for failure cassettes (TODO)
1. Use recorded cassettes in other specs (e.g. model specs)
