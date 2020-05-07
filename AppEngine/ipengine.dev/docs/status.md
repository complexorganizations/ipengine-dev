### Status Codes
A list of status codes and their meanings as returned by the API.

ipengine uses conventional HTTP response codes to indicate whether an API request is successful or not.

| Status Code               | Description                                                       |
|---------------------------|-------------------------------------------------------------------|
| 1xx (informational)       | The request was received, and procedure proceeded                 |
| 2xx (successful)          | The application was received successfully, and approved           |
| 3xx (redirection)         | Further action is required to complete the request                |
| 4xx (client error)        | The question includes poor syntax or is not compliant             |
| 5xx (server error)        | The server failed to fulfill a seemingly legitimate request       |
| 200 (OK)                  | Standard response for successful HTTP requests                    |
| 302 (Moved)	              | Any future requests should be addressed to the URI provided       |
| 400 (Bad Request)         | The server can not process the request, or will not process it    |
| 401 (Unauthorized)        | No valid API key provided.                                        |
| 402 (Request Failed)      | The parameters were valid but the request failed.                 |
| 403 (Forbidden)           | The request contained valid data, which the server understood     |
| 404 (Not Found)           | Unable to locate the required tool                                |
| 404 (Requests Limit)      | Excessively many requests hit the API too fast                    |
| 500 - 505 (Server Error)  | The server is unable to process the request                       |
