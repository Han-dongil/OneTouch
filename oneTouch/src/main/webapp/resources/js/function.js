function lpad(str,padLen,padStr){
	str+="";
	padStr+="";
	while(str.length<padLen)
		str=padStr+str;
	str=str.length>=padLen ? str.substring(0,padLen) : str;
	return str;
}