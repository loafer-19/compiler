	AREA TEXT,CODE,READWRITE
	ENTRY
	MOV R0,#100   ;循环数目
	MOV R1,#0	     ;初始化数据
LOOP
	ADD R1,R1,R0  ;将数据进行相加，获得最后的数据
	SUBS R0,R0,#1 ;循环数据R0减去1
	CMP R0,#0	     ;将R0与0比较看循环是否结束
	BNE LOOP	     ;判断循环是否结束，接受则进行下面的步骤	
	LDR R2,=RESULT
	STR R1,[R2]
RESULT
	DCD 0
STOP
	B STOP

