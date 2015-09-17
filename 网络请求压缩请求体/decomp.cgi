#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "Hello, World.\n";
print "Body=\n";
foreach (<>) {
        print;
}
