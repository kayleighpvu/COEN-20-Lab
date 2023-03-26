			.syntax	unified
			.cpu	cortex-m4
			.text
			.global	Zeller1 // Baseline using divide and multiply
			.thumb_func
			.align
Zeller1:	// R0=k, R1=m, R2=D, R3=C
			//use MUL, MLS, UDIV, SDIV
			PUSH {R4-R11}
			ADD R4, R0, R2				//R4=k+D
			ADD R4, R4, R2, LSR 2		//R4=k+D+D/4
			ADD R4, R4, R3, LSR 2		//R4=k+D+D/4+C/4
			SUB R5, R4, R3, LSL 1		//R5=k+D+D/4+C/4-2C
			
			LDR R12,=13
			MUL R6, R12, R1				//R6=13*m
			SUB R7, R6, 1				//R7=13m-1
			
			LDR R12,=5
			UDIV R8, R7, R12			//R2=(13m-1)/5
			ADD R9, R5, R8				//get f (R9=f)
			
			LDR R12,=7
			SDIV R11, R9, R12			//R11=f/7
			MLS R11, R12, R11, R9		//R11=f-(7*R11)
			
			CMP R11, 0					//compare R11 to 0
			IT LT						//if R11 is less than 0
			ADDLT R11, R11, 7			//R11+=7
			
			MOV R0,R11					//move R11 to R0
			POP {R4-R11}
			BX		LR					//return

			.global	Zeller2 // No multiply instructions
			.thumb_func
			.align
Zeller2:	// R0=k, R1=m, R2=D, R3=C
			//use UDIV, SDIV
			PUSH {R4-R11}
			ADD R4, R0, R2				//R4=k+D
			ADD R4, R4, R2, LSR 2		//R4=k+D+D/4
			ADD R4, R4, R3, LSR 2		//R4=k+D+D/4+C/4
			SUB R5, R4, R3, LSL 1		//R5=k+D+D/4+C/4-2C
		
			ADD R6, R1, R1, LSL 3		//R6=m+8m=9m
			ADD R6, R6, R1, LSL 2		//R6=9m+4m=13m-1
			SUB R7, R6, 1				//R7=13m-1
			
			LDR R12,=5
			UDIV R8, R7, R12			//R8=(13m-1)/5
			ADD R9, R5, R8				//get f
			
			LDR R12,=7
			SDIV R11, R9, R12			//R11=f/7
			LSL R12, R11, 3				//R12=R11*8
			SUB R11, R12, R11			//R11=8R11-R11=7R11
			SUB R11, R9, R11			//R11=f-R11
			
			CMP R11, 0					//compare R11 to 0
			IT LT						//if less than
			ADDLT R11, R11, 7			//then R1+=7
			
			MOV R0, R11					//move R11 to R0
			POP {R4-R11}
			BX		LR					//return

			.global	Zeller3 // No multiply or divide instructions
			.thumb_func
			.align
Zeller3:	// R0=k, R1=m, R2=D, R3=C
			//no multiplication or division
			PUSH {R4-R11}
			ADD R4, R0, R2				//R4=k+D
			ADD R4, R4, R2, LSR 2		//R4=k+D+D/4
			ADD R4, R4, R3, LSR 2		//R4=k+D+D/4+C/4
			SUB R5, R4, R3, LSL 1		//R5=k+D+D/4+C/4-2C
			
			ADD R6, R1, R1, LSL 3		//R6=m+8m=9m
			ADD R6, R6, R1, LSL 2		//R6=9m+4m=13m-1
			SUB R7, R6, 1				//R7=13m-1
			
			LDR R12,=3435973837			//magic constant
			UMULL R0,R12,R12,R7			//(R12*R7) taking least sig digit to R12 and most to R0
			LSRS R1, R12, 2				//R1=(13m-1)/5
			ADD R0, R1, R5				//get f=R0
			
			//R0=f
			LDR R12,=2454267027			//magic constant
			SMMLA R12, R12, R0, R0		//R12=f+(R12*f)
			LSRS R3, R0, 31				//R3=R0*(2^31)
			ADD R1, R3, R12, ASR 2		//get quotient
			RSB R1, R1, R1, LSL 3		//R1=8R1-R1=7R1 divisor
			SUB R0, R0, R1				//R0=f-R1
			
			CMP R0, 0					//compare R0 to 0
			IT LT						//if less than
			ADDLT R0, R0, 7				//then R1+=7
			
			POP {R4-R11}
			BX		LR
			.end
