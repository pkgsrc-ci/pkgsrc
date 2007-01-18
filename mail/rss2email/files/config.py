# The email address messages are from by default:
DEFAULT_FROM = "bozo@dev.null"

# 1: Only use the DEFAULT_FROM address.
# 0: Use the email address specified by the feed, when possible.
FORCE_FROM = 0

# 1: Receive HTML mail
# 0: Have entries converted to plain text
HTML_MAIL = 1

# 1: Receive one email per post
# 0: Receive an email every time a post changes
TRUST_GUID = 1

# 1: Generate Date header based on item's date, when possible
# 0: Generate Date header based on time sent
DATE_HEADER = 0

# 1: Apply Q-P conversion (required for some MUAs)
# 0: Send message in 8-bits
# http://cr.yp.to/smtp/8bitmime.html
QP_REQUIRED = 0

# 1: Name feeds as they're being processed.
# 0: Keep quiet.
VERBOSE = 0
