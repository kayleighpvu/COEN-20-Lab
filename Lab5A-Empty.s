				.syntax     unified
				.cpu        cortex-m4
				.text
				.global     Discriminant
				.thumb_func
				.align
				// int Discriminant(int32_t a, int32_t b, int32_t c) ;
Discriminant:	
				MUL R1, R1, R1		//R1=b, b*b=R1*R1
				MUL R0, R2, R0		//multiply 4 and a
				LSL R0,R0,2			//left shifting R0 by 2 
				SUB R0, R1, R0		//R0=R1-R0
				BX LR

				.global     Root1
				.thumb_func
				.align
				// int Root1(int32_t a, int32_t b, int32_t c) ;
Root1:			
				PUSH {R4, R5, LR}
				MOV R4,R0			//preserving parameters a and b
				MOV R5, R1			//a->R4 and b->R5
				BL Discriminant		//calling Discriminant function
				BL SquareRoot		//calling SquareRoot function from Main code
				SUBs R1, R0, R5		//R1 = b - sqrt(discriminant)
				LSLs R4, R4, 1		//left shifting R4 (a) of 1 value to multiply by 2
				SDIV R0, R1, R4		//signed division R0=R4/R1
				POP {R4, R5, LR}
				BX LR

				.global     Root2
				.thumb_func
				.align
				// int Root2(int32_t a, int32_t b, int32_t c) ;
Root2:			
				PUSH {R4, R5, LR}
				MOV R4, R0		
				MOV R5, R1
				BL Discriminant		
				BL SquareRoot			
				LDR R3,=-1			//set int -1 to unused scratch register
				SUBs R0, R0, R5		//b subtract sqrt(discriminant)
				MUL R1, R0, R3		//multiply whole equation by -1
				LDR R3,=2			//overriding R3 to new value and setting int 2
				MUL	R0,	R4,	R3		//R0=a*2 (can also use LSL)
				SDIV R0, R1, R0		//signed division R0=R1/R0
				POP {R4, R5, LR}	//returning the pushed registers
				BX LR

				.global     Quadratic
				.thumb_func
				.align
				// int32_t Quadratic(int32_t x, int32_t a, int32_t b, int32_t c) ;
Quadratic:  	

				MLA R1, R1, R0, R2	//R1=(a*x)+b
				MLA R0, R1, R0, R3  //R1=c+x*(b+a*x)
				BX LR
				
				.end
