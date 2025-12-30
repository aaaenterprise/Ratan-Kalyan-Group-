// ignore_for_file: non_constant_identifier_names

class HttpStatusCodes {
  /// HTTP status code for "Continue" (100): The server has received the request headers and the client should proceed to send the request body.
  static int get CONTINUE => 100;

  /// HTTP status code for "Switching Protocols" (101): The server is indicating that it is changing protocols to the one specified in the Upgrade header field of the request.
  static int get SWITCHING_PROTOCOLS => 101;

  /// HTTP status code for "Processing" (102): The server has received and is processing the request, but no response is available yet.
  static int get PROCESSING => 102;

  /// HTTP status code for "Early Hints" (103): Used to return some response headers before the final response.
  static int get EARLY_HINTS => 103;

  /// HTTP status code for "OK" (200): The request was successful, and the server has returned the requested data.
  static int get OK => 200;

  /// HTTP status code for "Created" (201): The request has been fulfilled, and a new resource has been created as a result.
  static int get CREATED => 201;

  /// HTTP status code for "Accepted" (202): The request has been accepted for processing, but the processing has not been completed.
  static int get ACCEPTED => 202;

  /// HTTP status code for "Non-Authoritative Information" (203): The server is a transforming proxy and has received a 200 OK response from the origin server, but returns a modified version of the response.
  static int get NON_AUTHORITATIVE_INFORMATION => 203;

  /// HTTP status code for "No Content" (204): The server has successfully fulfilled the request, but there is no additional content to send in the response.
  static int get NO_CONTENT => 204;

  /// HTTP status code for "Reset Content" (205): The server has fulfilled the request, and the user agent should reset the document view.
  static int get RESET_CONTENT => 205;

  /// HTTP status code for "Partial Content" (206): The server has fulfilled a partial GET request.
  static int get PARTIAL_CONTENT => 206;

  /// HTTP status code for "Multi-Status" (207): The message body that follows is an XML message and can contain a number of separate response codes, depending on how many sub-requests were made.
  static int get MULTI_STATUS => 207;

  /// HTTP status code for "Already Reported" (208): The members of a DAV binding have already been enumerated in a preceding part of the (multistatus) response, and are not being included again.
  static int get ALREADY_REPORTED => 208;

  /// HTTP status code for "IM Used" (226): The server has fulfilled a request for the resource, and the response is a representation of the result of one or more instance-manipulations applied to the current instance.
  static int get IM_USED => 226;

  /// HTTP status code for "Multiple Choices" (300): The requested resource has multiple representations, and the user agent has no preference as to which one to serve.
  static int get MULTIPLE_CHOICES => 300;

  /// HTTP status code for "Moved Permanently" (301): The requested resource has been assigned a new permanent URI and any future references to this resource should use one of the returned URIs.
  static int get MOVED_PERMANENTLY => 301;

  /// HTTP status code for "Found" (302): The requested resource resides temporarily under a different URI.
  static int get FOUND => 302;

  /// HTTP status code for "See Other" (303): The server is redirecting the user agent to a different resource, as indicated by the URI in the Location header field.
  static int get SEE_OTHER => 303;

  /// HTTP status code for "Not Modified" (304): The resource has not been modified since the version specified in If-Modified-Since or If-None-Match headers in the request.
  static int get NOT_MODIFIED => 304;

  /// HTTP status code for "Use Proxy" (305): The requested resource is available only through a proxy, the address for which is provided in the response.
  static int get USE_PROXY => 305;

  /// HTTP status code for "Temporary Redirect" (307): The request should be repeated with another URI; however, future requests should still use the original URI.
  static int get TEMPORARY_REDIRECT => 307;

  /// HTTP status code for "Permanent Redirect" (308): The request and all future requests should be repeated using another URI.
  static int get PERMANENT_REDIRECT => 308;

  /// HTTP status code for "Bad Request" (400): The server could not understand the request due to invalid syntax.
  static int get BAD_REQUEST => 400;

  /// HTTP status code for "Unauthorized" (401): The request has not been applied because it lacks valid authentication credentials for the target resource.
  static int get UNAUTHORIZED => 401;

  /// HTTP status code for "Payment Required" (402): Reserved for future use; currently, it is not used.
  static int get PAYMENT_REQUIRED => 402;

  /// HTTP status code for "Forbidden" (403): The server understood the request, but it is refusing to fulfill it.
  static int get FORBIDDEN => 403;

  /// HTTP status code for "Not Found" (404): The server has not found anything matching the requested URI.
  static int get NOT_FOUND => 404;

  /// HTTP status code for "Method Not Allowed" (405): The method specified in the request is not allowed for the resource identified by the request URI.
  static int get METHOD_NOT_ALLOWED => 405;

  /// HTTP status code for "Not Acceptable" (406): The resource identified by the request is only capable of generating response entities that have content characteristics not acceptable according to the accept headers sent in the request.
  static int get NOT_ACCEPTABLE => 406;

  /// HTTP status code for "Proxy Authentication Required" (407): The client must first authenticate itself with the proxy.
  static int get PROXY_AUTHENTICATION_REQUIRED => 407;

  /// HTTP status code for "Request Timeout" (408): The server timed out waiting for the request.
  static int get REQUEST_TIMEOUT => 408;

  /// HTTP status code for "Conflict" (409): The request could not be completed due to a conflict with the current state of the target resource.
  static int get CONFLICT => 409;

  /// HTTP status code for "Gone" (410): The requested resource is no longer available at the server, and no forwarding address is known.
  static int get GONE => 410;

  /// HTTP status code for "Length Required" (411): The server requires the request to be in a specific format, usually because it is missing a Content-Length header.
  static int get LENGTH_REQUIRED => 411;

  /// HTTP status code for "Precondition Failed" (412): The server does not meet one of the preconditions specified in the request headers.
  static int get PRECONDITION_FAILED => 412;

  /// HTTP status code for "Payload Too Large" (413): The request is larger than the server is willing or able to process.
  static int get PAYLOAD_TOO_LARGE => 413;

  /// HTTP status code for "URI Too Long" (414): The URI provided in the request is too long for the server to process.
  static int get URI_TOO_LONG => 414;

  /// HTTP status code for "Unsupported Media Type" (415): The request entity has a media type that the server or resource does not support.
  static int get UNSUPPORTED_MEDIA_TYPE => 415;

  /// HTTP status code for "Range Not Satisfiable" (416): The server cannot provide a response that matches the list of ranges specified in the request headers.
  static int get RANGE_NOT_SATISFIABLE => 416;

  /// HTTP status code for "Expectation Failed" (417): The expectation given in the request's Expect header field cannot be met by the server.
  static int get EXPECTATION_FAILED => 417;

  /// HTTP status code for "I'm a teapot" (418): This code was defined in 1998 as one of the traditional IETF April Fools' jokes.
  static int get IM_A_TEAPOT => 418;

  /// HTTP status code for "Misdirected Request" (421): The request was directed at a server that is not able to produce a response.
  static int get MISDIRECTED_REQUEST => 421;

  /// HTTP status code for "Unprocessable Entity" (422): The request was well-formed but was unable to be followed due to semantic errors.
  static int get UNPROCESSABLE_ENTITY => 422;

  /// HTTP status code for "Locked" (423): The resource that is being accessed is locked.
  static int get LOCKED => 423;

  /// HTTP status code for "Failed Dependency" (424): The request failed because it depended on another request and that request failed.
  static int get FAILED_DEPENDENCY => 424;

  /// HTTP status code for "Too Early" (425): Indicates that the server is unwilling to risk processing a request that might be replayed.
  static int get TOO_EARLY => 425;

  /// HTTP status code for "Upgrade Required" (426): The client should switch to a different protocol, such as TLS/1.0.
  static int get UPGRADE_REQUIRED => 426;

  /// HTTP status code for "Precondition Required" (428): The origin server requires the request to be conditional.
  static int get PRECONDITION_REQUIRED => 428;

  /// HTTP status code for "Too Many Requests" (429): The user has sent too many requests in a given amount of time.
  static int get TOO_MANY_REQUESTS => 429;

  /// HTTP status code for "Request Header Fields Too Large" (431): The server is unwilling to process the request because its header fields are too large.
  static int get REQUEST_HEADER_FIELDS_TOO_LARGE => 431;

  /// HTTP status code for "Unavailable For Legal Reasons" (451): A server operator has received a legal demand to deny access to a resource or to a set of resources.
  static int get UNAVAILABLE_FOR_LEGAL_REASONS => 451;

  /// HTTP status code for "Internal Server Error" (500): An unexpected condition was encountered by the server, and no more specific message is suitable.
  static int get INTERNAL_SERVER_ERROR => 500;

  /// HTTP status code for "Not Implemented" (501): The server does not support the functionality required to fulfill the request.
  static int get NOT_IMPLEMENTED => 501;

  /// HTTP status code for "Bad Gateway" (502): The server, while acting as a gateway or proxy, received an invalid response from the upstream server it accessed in attempting to fulfill the request.
  static int get BAD_GATEWAY => 502;

  /// HTTP status code for "Service Unavailable" (503): The server is currently unable to handle the request due to temporary overloading or maintenance of the server.
  static int get SERVICE_UNAVAILABLE => 503;

  /// HTTP status code for "Gateway Timeout" (504): The server, while acting as a gateway or proxy, did not receive a timely response from the upstream server or application.
  static int get GATEWAY_TIMEOUT => 504;

  /// HTTP status code for "HTTP Version Not Supported" (505): The server does not support the HTTP protocol version that was used in the request.
  static int get HTTP_VERSION_NOT_SUPPORTED => 505;

  /// HTTP status code for "Variant Also Negotiates" (506): Transparent content negotiation for the request results in a circular reference.
  static int get VARIANT_ALSO_NEGOTIATES => 506;

  /// HTTP status code for "Insufficient Storage" (507): The server is unable to store the representation needed to complete the request.
  static int get INSUFFICIENT_STORAGE => 507;

  /// HTTP status code for "Loop Detected" (508): The server detected an infinite loop while processing a request.
  static int get LOOP_DETECTED => 508;

  /// HTTP status code for "Bandwidth Limit Exceeded" (509): The server has exceeded the bandwidth specified by the server operator.
  static int get BANDWIDTH_LIMIT_EXCEEDED => 509;

  /// HTTP status code for "Not Extended" (510): Further extensions to the request are required for the server to fulfill it.
  static int get NOT_EXTENDED => 510;

  /// HTTP status code for "Network Authentication Required" (511): The client needs to authenticate to gain network access.
  static int get NETWORK_AUTHENTICATION_REQUIRED => 511;
}
