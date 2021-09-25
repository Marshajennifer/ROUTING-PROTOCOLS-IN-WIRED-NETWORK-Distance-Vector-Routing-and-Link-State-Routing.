BEGIN{
routing=0
send=0
received=0
dropped=0
}
{
if($1=="r" && $5=="rtProtoLS")
	{
	routing=routing+1
	}
if ( $1=="+" && $3=="0" || $3=="1" && $5=="cbr") 
	{
	send=send + 1
	}
if($1=="r" && $4=="5" && $5=="cbr")
	{
	received=received+1
	}
if($1=="d") 
	{
	dropped=dropped+1
	}
}

END{
printf("No.of routing packets:%f\n",routing)
printf("No.of send packets:%f\n",send)
printf("No. of received packets:%f\n",received)
printf("No. of dropped packets:%f\n",dropped)
printf("Normalized overhead:%f\n",routing/received)
printf("Packet Delivery Ratio:%f\n",received/send)
printf("Packet Loss Ratio:%f\n",send-received)
}
