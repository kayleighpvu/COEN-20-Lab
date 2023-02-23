				.syntax		unified
				.cpu		cortex-m4
				.text
				// ------------------------------------------------------------------------
				// void MatrixMultiply(int32_t a[3][3], int32_t b[3][3], int32_t c[3][3]) ;
				// ------------------------------------------------------------------------
				.global		MatrixMultiply
				.thumb_func
				.align
MatrixMultiply:	// R0 = &a, R1 = &b, R2 = &c
				PUSH	{R4-R10,LR}
				MOV R4,R0					//Preserving a,b,c R4=a[][]
				MOV R5, R1					//R5=b[][]
				MOV R6, R2					//R6=c[][]
				LDR R7,=0					//set row to R7
				LDR R10,=3					//R10<--3
				
NxtRow:			CMP R7,3					//comparing row number to 3
				BGE	EndRow					//if row number is >= than 3 then branch to EndRow
				LDR R8,=0					//set column to R8

NxtCol:			CMP R8,3					//comparing column number to 3
				BGE EndCol					//if column number is >= than 3 then branch to EndCol
				MLA R3,R10,R7,R8			//R3<--3*row+column
				LDR R0,=0					//setting R0 to 0
				STR R0,[R4,R3,LSL 2]		//Storing 0 --> left shift 2 to multiply 4 with R3, add it with R4 (a) 
				
				LDR R9,=0					//set 0 to k
NxtK:			CMP R9,3					//comparing k to 3
				BGE EndK					//if k is >= 3 then branch to EndK
				MLA R3,R10,R7,R8			//R3=3*row+column
				LDR	R0,[R4,R3,LSL 2]		//R0=a[row][column]
				MLA R3,R10,R7,R9			//R3=3*row+k
				LDR R1,[R5,R3,LSL 2]		//R1=b[row][k]
				MLA R3,R10,R9,R8			//R3=3*k+column
				LDR R2,[R6,R3,LSL 2]		//R2=c[k][column]
				
				BL MultAndAdd
				
				MLA R3,R10,R7,R8			//R3=3*row+column
				STR R0,[R4,R3,LSL 2]		//R0=a[row][column]
				ADD R9,R9,1					//k++
				
				B NxtK

EndK:			ADD R8,R8,1					//column++
				BL NxtCol					//branching back to NxtK
	
EndCol:			ADD R7,R7,1					//row++
				BL NxtRow					//branching back to NxtRow
				
EndRow: 		POP		{R4-R10,PC}
				.end

