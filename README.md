# communigate_script

https://www.communigate.com/CGPerl/

base script https://www.communigate.com/CGPerl/CreateUserCGI.pl

Installation: Simply copy the CLI.pm file into one of the @INC directories. The list of @INC directories is displayed by perl -V command.

Note: The CGP::CLI class uses IO::Socket::INET class. Depending on your Perl setup, you may need to modify your CLI.pm file and change the use IO::Socket; line into use IO::Socket::INET;.

Note: The CLI.pm uses Digest::MD5 module. If you don't have MD5 module installed, you'll have to download and install it.
