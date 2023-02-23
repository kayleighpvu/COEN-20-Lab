			.syntax		unified
			.cpu		cortex-m4
			.text
			// int32_t Add(int32_t a, int32_t b) ;
			.global		Add
			.thumb_func
			.align
Add:		//Implement me
			ADD R0, R0, R1 //adding R0 and R1 to R0
			BX			LR

			// int32_t Less1(int32_t a) ;
			.global		Less1
			.thumb_func
			.align
Less1:		//Implement me
			SUB R0, R0, 1 //subtracting 1 from R0 
			BX			LR

			// int32_t Square2x(int32_t x) ;
			.global		Square2x
			.thumb_func
			.align
Square2x:	//Implement me
			PUSH {R4, LR}
			ADD R0,R0,R0 //adding to itself 2 times
			BL Square
			POP {R4, PC}

			// int32_t Last(int32_t x) ;
			.global		Last
			.thumb_func
			.align
Last:		//Implement me
			PUSH {R4, LR}
			MOV R4,R0
			BL SquareRoot
			ADD R0, R0, R4
			POP {R4, PC}
			.end
