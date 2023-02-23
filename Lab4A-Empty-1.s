			.syntax     unified
			.cpu        cortex-m4
			.text
			
			// void UseLDRB(void *dst, void *src) ;
			.global     UseLDRB
			.thumb_func
			.align
UseLDRB:	
			.rept 512			//repeats n(512) times
			LDRB R2,[R1],1		//loads R2 with contents of address pointed by R1 and increment 1 
			STRB R2,[R0],1		//stores byte of R1 into contents of R0 and increments by 1
			.endr
			BX          LR

			// void UseLDRH(void *dst, void *src) ;
			.global     UseLDRH
			.thumb_func
			.align
UseLDRH:	
			.rept 256 			//repeats n(256) times 
			LDRH R2,[R1],2		//increments by 2
			STRH R2,[R0],2		//increments by 2
			.endr
			BX          LR	

			// void UseLDR(void *dst, void *src) ;
			.global     UseLDR
			.thumb_func
			.align
UseLDR:		
			.rept 128 			//repeats n(128) times
			LDR R2,[R1],4		//reads and increments by 4		
			STR R2,[R0],4		//stores and increments by 4
			.endr
			BX          LR

			// void UseLDRD(void *dst, void *src) ;
			.global     UseLDRD
			.thumb_func
			.align
UseLDRD:	
			.rept 64				//repeats n(64) times
			LDRD R2,R3,[R1],8		//loads 64 bits into R2 and R3, and increments by 8
			STRD R2,R3,[R0],8		//stores and increments by 8
			.endr
			BX          LR

			// void UseLDMIA(void *dst, void *src) ;
			.global     UseLDM
			.thumb_func
			.align
UseLDM:		
			PUSH {R4-R12}
			.rept 16					//repeats n(16) times 
			LDMIA R1!,{R4-R12}			//using stratch registers R4-R12, loading contents of R1 into multiple registers R4-R12
 			STMIA R0!,{R4-R12}			//stores contents of R4-R12
			.endr
			POP {R4-R12}				//restores original R4-R12
			BX          LR
			.end
