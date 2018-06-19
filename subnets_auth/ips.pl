#!/usr/bin/perl
 
use NetAddr::IP;
 
my $network;
my $remoteIP;
my @iparray;
my $found;
my $file="/etc/httpd/conf.d/all_clients.txt";
# Turn off I/O buffering
$| = 1;
 
while (<STDIN>) {
  $remoteIP = $_;
  $remoteIP =~ s/[\t\n\f\r]|^\s+|\s+$//g; 

  open(fh, "<", "$file") or die "Can't open $file for read: $!";
  @iparray=<fh>;
  #print "$#iparray\n";
  close $fh;
 
  $visitor = NetAddr::IP->new($remoteIP);
  if ( !defined ($visitor) ) { print "notfound\n"; next; }
  foreach my $cidr (@iparray) {
    $cidr =~ s/[\t\n\f\r]|^\s+|\s+$//g; 
    $network = NetAddr::IP->new($cidr);
    next if ( "$network" =~ m/^$|^#/ );
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
