# NitBForce
This script try to brute-force directories and files by using the wordlist provided by the user.
```
$./nitbforce.sh -h

NitBForce Script
-h -- Open this manual
-u -- Specifies the URL to attack.
-w -- set a wordlist for files.

-e [OPTIONAL] -- Specifies an extension. Used to brute force files.
		 php, txt, asp, pdf...

Usage example: ./script.sh -u example-site.com -w wordlist
Usage example: ./script.sh -u example-site.com -w wordlist -e php
```

I tried change the way arguments were passed a little bit. Previously, I obtained the arguments using 'Positional arguments'(Like $1, $2...), but I think using options to control it, the use of the program appears to be more "Original"(or something like that).

# How it Works

This tool uses `curl` to make a request to an specific directory in an wordlist and will return wheater that directory exists(marked as existing if the response has the 200 and 301 HTTP Status Code). It can also make a request to verify if a file(with an especific extension) exists. 

It is not necessary to search for files.
