#!/bin/perl
 
use strict;
use warnings;
 
use NetAddr::IP;
 
my $network;
my $remoteIP;
my @iparray;
my $found;
# Turn off I/O buffering
$| = 1;
 
open(my $fh, "<", "/etc/httpd/conf.d/all_clients.txt");
while(<$fh>) { 
    chomp; 
    push @iparray, $_;
} 
close $fh;
 
while (<STDIN>) {
  my $visitor;
  $remoteIP = $_;
  chomp $remoteIP;
 
  $visitor = NetAddr::IP->new($remoteIP);
 
  if ( !defined ($visitor) ) { print "notfound\n"; next; }
  foreach my $cidr (@iparray) {
    chomp $cidr;
 
    $network = NetAddr::IP->new($cidr);
 
    if ( $visitor->within($network) ) {
      $found = 1;
      print "allow\n";
      last;
    }
  }
  if ( !$found ) { print "notfound\n"; }
  undef $visitor;
  undef $remoteIP;
  undef $found;
}
