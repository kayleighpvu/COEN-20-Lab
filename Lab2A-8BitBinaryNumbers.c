#include <stdint.h>

uint32_t Bits2Unsigned(int8_t bits[8]){
	uint32_t value = 0; //set initial value to 0
	int i; //variable for for loop
	
	for (i=7; i>=0; i--){  //loop for polynomial unsigned values
		value = 2 * value + bits[i]; 
	}
	return value;
}

int32_t Bits2Signed(int8_t bits[8]){
	int32_t value = Bits2Unsigned(bits); //calls Bits2Unsigned function with value called bits
	
	if (value >= 128){
		value -= 256; //due to rollover, change range to -128 to 127
	}
	return value; //returns the result
}

void Increment(int8_t bits[8]){
	int32_t bit, carry, sum;
	int i;
	
	for(i = 0; i <= 7; i++){
		if (bits[i] == 0){
			bits[i] = 1; //this increments the value
			break;
		}
		if (bits[i] == 1){
			bits[i] = 0; //keeps the loop by changing value of bits[i] to 0;
		}
	}
}

void Unsigned2Bits(uint32_t n, int8_t bits[8]){
	int32_t bit;
	
	for (bit=0; bit<= 7; bit++){ //repeated division
		bits[bit] = n % 2; //get remainder
		n = n/2; 
	}
	
}
