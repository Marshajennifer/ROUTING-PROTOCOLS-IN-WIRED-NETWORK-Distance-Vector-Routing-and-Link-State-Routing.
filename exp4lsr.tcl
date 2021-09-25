#Distance Vector Routing
set ns [new Simulator]
set tracefile [open exp4lsr.tr w]
$ns trace-all $tracefile
set namfile [open exp4lsr.nam w]
$ns namtrace-all $namfile


proc finish {} {
	global ns tracefile namfile
	$ns flush-trace
	close $tracefile
	close $namfile
	exit 0
}


set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]
set n11 [$ns node]

$ns duplex-link $n0 $n9 1Mb 10ms DropTail
$ns duplex-link $n9 $n11 1Mb 10ms DropTail
$ns duplex-link $n11 $n5 1Mb 10ms DropTail
$ns duplex-link $n1 $n10 1Mb 10ms DropTail
$ns duplex-link $n10 $n11 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n3 $n4 1Mb 10ms DropTail
$ns duplex-link $n4 $n5 1Mb 10ms DropTail
$ns duplex-link $n6 $n5 1Mb 10ms DropTail
$ns duplex-link $n7 $n6 1Mb 10ms DropTail
$ns duplex-link $n8 $n7 1Mb 10ms DropTail
$ns duplex-link $n0 $n8 1Mb 10ms DropTail
$ns duplex-link $n0 $n1 1Mb 10ms DropTail



set udp0 [new Agent/UDP]
set null5 [new Agent/Null]
$ns attach-agent $n0 $udp0
$ns attach-agent $n5 $null5
$ns connect $udp0 $null5
$udp0 set fid_ 1
$ns color 1 Blue

set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set null5 [new Agent/Null]
$ns attach-agent $n5 $null5
$ns connect $udp1 $null5
$udp1 set fid_ 2
$ns color 2 Red


set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
$cbr0 set type_ CBR
$cbr0 set packetsize_ 500
$cbr0 set interval_ 0.005


set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
$cbr1 set type_ CBR
$cbr1 set packetsize_ 500
$cbr1 set interval_ 0.005


$ns rtproto LS
$ns rtmodel-at 10 down $n11 $n5
$ns rtmodel-at 15 down $n7 $n6
$ns rtmodel-at 30 up $n11 $n5
$ns rtmodel-at 20 up $n7 $n6
$ns at 5.0 "$cbr0 start"
$ns at 5.0 "$cbr1 start"

$ns at 45 "$cbr0 stop"
$ns at 45 "$cbr1 stop"
$ns at 50 "finish"
$ns run

