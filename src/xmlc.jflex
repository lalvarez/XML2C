import java.io.*;
%%
%class transform
%unicode
%line
%column
%type Object

//Macrodefinitions(?) 
//Macros are abbreviations of regular expressions
c =	[cC] //LTo ignore uppercase(?)
f =	[fF]
i =     [Ii]
n =     [Nn]
o =     [Oo]
t =     [Tt]
u =     [Uu]

%{
int state;
boolean call =false;
int counter = 0;
	public static void main(String [] args) throws IOException
	{
		transform lexer = new transform(new FileReader(args[0]));
		System.out.println("int a,b,c,d,e,f,g,h,i,j,k,l,m;");
		System.out.println("int n,o,p,q,r,s,t,u,v,w,x,y,z;");
		System.out.println();
		lexer.yylex();
	}
%}

%%
"<"{f}{u}{n}{c}{t}{i}{o}{n}			{state = 1; counter++;} //LCuando lee funcion va al estado 1
"</"{f}{u}{n}{c}{t}{i}{o}{n}">"		{System.out.println("}"); counter--; state = 0; } //LFin de la funcion imprime } y state 0
"<if"								{for (int i=0;i<counter;i++) System.out.print("   ");System.out.print("if");counter++; state = 10;}
"</if>"								{for (int i=0;i<counter;i++) System.out.print("   ");System.out.println("}");counter--;}
"<else/>"							{for (int i=0;i<counter;i++) System.out.print("   ");System.out.println("}");counter--;for (int i=0;i<counter;i++) System.out.print("   ");System.out.print("else");System.out.println("{");counter++;}
"<add"								{state = 4;}
"<sub"								{state = 14;}
"<call"								{state = 30;}
"/>"								{if (call == true) System.out.print(")");System.out.println(";");call=false;}
"<return"							{state = 20;}
"<"									{System.out.println("\n");}
">"									{if ((state == 2)||(state==3) || (state == 33)) {
										System.out.println(") {"); 	//LEstado 2 o 3 means final parametros (?)		
										state=0;}
									}
\"[^\"]*\"							{ 
										//FUNTION 
                                        if (state == 1) {  // function name
											int len = yytext().length();
                                            System.out.print("int "+yytext().substring(1,len-1) +"(");
                                            state = 2;
                                          } 
										else if (state == 2) {  // params
											int len = yytext().length();
                                            System.out.print("int "+yytext().substring(1,len-1) );
                                            state = 3;
                                          } 
										else if (state == 3) {  // params
											int len = yytext().length();
                                            System.out.print(", int "+yytext().substring(1,len-1) );
										  }
									
										//ADDITION
										if (state == 4) {
											int len = yytext().length();
                                            for (int i=0;i<counter;i++) System.out.print("   ");
											System.out.print(yytext().substring(1,len-1) +" = ");
                                            state = 5;
										}
										else if (state == 5) {
											int len = yytext().length();
                                            System.out.print(yytext().substring(1,len-1));
                                            state = 6;
                                          } 
										else if (state == 6) {  
											int len = yytext().length();
                                            System.out.print("+" + yytext().substring(1,len-1));
                                            state = 6;
                                          } 
										  
										//IF STATEMENT
										else if (state == 10) {  // Condition
											int len = yytext().length();
                                            System.out.println("(" + yytext().substring(1,len-1) + ")" + "{" );
											state =0;
                                          }
										
										//RETURN VALUE
										else if (state == 20){
											int len = yytext().length();
											for (int i=0;i<counter;i++) System.out.print("   ");
											System.out.print("return "+yytext().substring(1,len-1));
											state =0;
										}
										
										//SUBSTRACTION
										else if (state == 14){
											int len = yytext().length();
											for (int i=0;i<counter;i++) System.out.print("   ");
											System.out.print(yytext().substring(1,len-1) +" = ");
											state = 15;
										}
										else if (state == 15) {  // params
											int len = yytext().length();
                                            System.out.print(yytext().substring(1,len-1));
                                            state = 16;
                                          } 
										else if (state == 16) {  // params
											int len = yytext().length();
                                            System.out.print("-" + yytext().substring(1,len-1));
											state = 16;
                                          } 
										
										//CALL
										else if (state == 30) {
											call = true;
											int len = yytext().length();
											String res_var = yytext().substring(1,len-1);
                                            for (int i=0;i<counter;i++) System.out.print("   ");
											System.out.print(res_var + " = ");
											state = 31;
										}
										else if (state == 31) {
											int len = yytext().length();
											System.out.print(yytext().substring(1,len-1) + "(");
											state = 32;
										}
										else if (state == 32) {
											int len = yytext().length();
                                            System.out.print(yytext().substring(1,len-1));
											state = 33;
										}
										else if (state == 33) {
											int len = yytext().length();
                                            System.out.print("," + yytext().substring(1,len-1));
											state = 33;
										}
										
									}
.									{}	
[\n]								{}	
//Scape sequence