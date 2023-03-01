				.syntax     unified
				.cpu        cortex-m4
				.text
				// unsigned ReverseBits(unsigned word) ;
				.global     ReverseBits
				.thumb_func
				.align
ReverseBits:	
				LDR R1,=0
				.rept 32			//repeat 32 times for 32 bits (range 0-31)
				LSLS R0, R0, 1		//shift left 1 bit
				RRX R1, R1			//rotating right 1 bit and store in R1
				.endr				//end loop
				MOV R0, R1			
				BX          LR		//return reversed

				// unsigned ReverseBytes(unsigned word) ;
				.global     ReverseBytes
				.thumb_func
				.align
ReverseBytes:	
				BFI R1, R0, 24, 8	//8 bits width and move to position 24, copy 8 bits to R1
				ROR R0, R0, 8		//rotate right 8 bits in R0

				BFI R1, R0, 16, 8
				ROR R0, R0, 8
				
				BFI R1, R0, 8, 8
				ROR R0, R0, 8
				
				BFI R1, R0, 0, 8
				ROR R0, R0, 8		
				 
				MOV R0, R1			//move data in R1 to R0
				BX          LR
				.end
