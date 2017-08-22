This RewriteMap is useful to authorize clients when your whitelist is very large and inclusive of a large list of subnets.
A text format RewriteMap only work with 1:1 matches. With this code you can have a subnets whitelist within searching.
Obviously Apache has "Require" directive for Location, Directory etc. but sometimes you are forced to combine this RewriteMap with many others RewriteCond.
