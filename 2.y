%{
	#include <iostream>
	#include <stdio.h>
	#include <string.h>
	#include <string.h>
	#include <sstream>
	#include <vector>
	 #include <string>
	using namespace std;
	
	extern int yylex();
  extern int yyparse();
  extern FILE *yyin;
	char * ctemp1 , ctemp2;
  

	extern int yylineno;
	
	void preOrder(struct tok *node);
	void preOrder2(struct tok *node);
	void tree(struct tok *node);
	
    void yyerror(const char *s);
    void yyerror2(int );
	int flag;
	int flag2;
	int numbers,ins;/* 1 reg 2 arrs 3 vars1*/
	FILE * datafile;
  
	FILE * textfile;
	string reg[8];
	int vars;
	int tvars;
	/*vector<string> vars1;
	vector<string> arrs;*/
	
	struct tdata{
	char type;/*b == bool  i = int  */
	string name;
	int value;/**/
	bool arr;
	int arr_size;
	bool varglobal;
	bool regs;
	bool regt;	
	int reg_num;
	};
	struct f{
	string name;
	bool has_args;
	vector <struct tdata> args;
	};
	vector <struct tdata> args2;
	vector<struct tdata> vars1;
	vector<struct f> funcs;
	struct tok{
		char* name;
		char* value;
		char location_type;
		string var_value;
		int exp_val;
		char cv;
		char gr;
		char exp_type;
		struct tok* next=NULL;
		struct tok* bef=NULL;
		struct tok* sibling=NULL;
		struct tok* child=NULL;
	};
	struct tdata re;
	struct tok* start;
	struct tok* end;
	struct tok* root;
	struct tok* last;
	struct tok* temp1;
	struct tok* temp2;
	struct tok* temp3;
	struct tok* temp4;
	struct tok* temp5;
	struct tok* temp6;
	struct tok* temp7;
	struct tok* temp8;
	struct tok* temp9;
	struct tok* temp10;
	struct tok* child1;
	struct tok* child2;
	struct tok* child3;
	struct tok* child4;
	struct tdata haha;
%}
%locations
%define parse.lac full
%define parse.error verbose

%union{
struct tok* token1;
char* c;
}

%token <c> TOKEN_DECIMALCONST
%token <c> TOKEN_HEXADECIMALCONST
%token <c> TOKEN_BOOLEANTYPE
%token <c> TOKEN_BREAKSTMT
%token <c> TOKEN_CALLOUT
%token <c> TOKEN_CLASS
%token <c> TOKEN_CONTINUESTMT
%token <c> TOKEN_ELSECONDITION
%token <c> TOKEN_BOOLEANCONST
%token <c> TOKEN_LOOP
%token <c> TOKEN_IFCONDITION
%token <c> TOKEN_INTTYPE
%token <c> TOKEN_RETURN
%token <c> TOKEN_VOIDTYPE
%token <c> TOKEN_PROGRAMCLASS
%token <c> TOKEN_MAINFUNC
%token <c> TOKEN_ID
%token <c> TOKEN_CHARCONST
%token <c> TOKEN_ARITHMATICOP1
%token <c> TOKEN_ARITHMATICOP2
%token <c> TOKEN_ARITHMATICOP3
%token <c> TOKEN_ARITHMATICOP4
%token <c> TOKEN_ARITHMATICOP5
%token <c> TOKEN_CONDITIONOP
%token <c> TOKEN_RELATIONOP
%token <c> TOKEN_EQUALITYOP
%token <c> TOKEN_ASSIGNOP
%token <c> TOKEN_LOGICOP
%token <c> TOKEN_LP
%token <c> TOKEN_RP
%token <c> TOKEN_LCB
%token <c> TOKEN_RCB
%token <c> TOKEN_LB
%token <c> TOKEN_RB
%token <c> TOKEN_SEMICOLON
%token <c> TOKEN_COMMA
%token <c> TOKEN_STRINGCONST




%type <token1>program

%type <token1>string_literal
%type <token1>callout_arg
%type <token1>callout_arg2
%type <token1> decl
%type <token1> field_dec2 
%type <token1>method_dec 
%type <token1>type 
%type <token1>id 
%type <token1>int_literal
%type <token1> method_dec2
%type <token1> method_dec3
%type <token1> block
%type <token1> toop
%type <token1> toop4
%type <token1> statement 
%type <token1>var_dec
%type <token1> method_call
%type <token1> expr2
%type <token1> expr3
%type <token1> method_name
%type <token1> expr location
%type <token1> literal
%type <token1> char_literal
%type <token1> bool_literal
%type <token1> bin_op
%type <token1> arith_op
%type <token1> rel_op 
%type <token1>eq_op 
%type <token1>cond_op 
%type <token1> f4 f3
%type <token1> var_dec2
%type <token1> statement2 

%%

program:
		TOKEN_CLASS TOKEN_PROGRAMCLASS TOKEN_LCB decl TOKEN_RCB  {
														 root = new tok();
													     $$=root;
	                                                     root->name = strdup("<program>");
											             root->value = strdup("<program>");
														 temp1 = new tok();
														 root->child = temp1;
														 temp1->name = strdup(" TOKEN_CLASS");
														 temp1->value = strdup(" class");
														 temp2 = new tok();
														 temp1->sibling = temp2;
														 temp2->name = strdup(" TOKEN_PROGRAMCLASS");
														 temp2->value = strdup(" Program");
														  temp3 = new tok();
														  temp2->sibling = temp3;
														 temp3->name = strdup(" TOKEN_LCB ");
														 temp3->value = strdup(" { ");
													
														 temp3->sibling = $4;
														 
														 temp4 = new tok();
														 temp4->name = strdup(" TOKEN_RCB ");
														 temp4->value = strdup(" } ");
														 $4->sibling = temp4;
													
}

decl :
		field_dec2 decl{$$ = new tok();
						$$->child = $1;
						$1->sibling=$2;
						$$->name = strdup("");
									$$->value = strdup("");
						}
		|
		method_dec3{$$ = new tok();
						$$->child = $1;
						
						$$->name = strdup("");
									$$->value = strdup("");
						}

field_dec2 :
			
			
			type f3 TOKEN_SEMICOLON {
									$$= new tok();
									$$->child = $1;
									$1->sibling=$2;
									temp1 = new tok();
									temp1->name = strdup(" TOKEN_SEMICOLON");
									temp1->value = strdup(" ;");
									$2->sibling = temp1;
									$$->name = strdup(" <field_dec>");
									$$->value = strdup(" <field_dec>");
									if(strcmp(" int",$1->child->value)==0){
									for(int i = vars1.size()-1;numbers>0;numbers--){
									vars1[i-(numbers-1)].type='i';
									}
									numbers=0;
									}else if(strcmp(" boolean",$1->child->value)==0)
									{
									for(int i = vars1.size()-1;numbers>0;numbers--){
									vars1[i-(numbers-1)].type='b';
									}
									numbers=0;
									}
									
									
									}

f3 : f4{$$= new tok();
					$$->child = $1;
					$$->name = strdup("");
					$$->value = strdup("");
					}
	|
	 f4 TOKEN_COMMA f3{$$= new tok();
					$$->child = $1;
					$$->name = strdup("");
					$$->value = strdup("");
					temp3 = new tok();
					temp3->name = strdup(" TOKEN_COMMA");
					temp3->value = strdup(" ,");
					$1->sibling = temp3;
					temp3->sibling = $3;}

f4 : id {$$= new tok();
					$$->child = $1;
					$$->name = strdup("");
					$$->value = strdup("");
					/*code generation*/
					flag = 0;
					
					for(int i = vars1.size()-1;i>=0;i--){
					
					if(vars1[i].name.compare($1->child->value)==0){
					cout<<"variable redefined"<<endl;
					exit(0);
					}
					
					}
					
					numbers++;
					ins = 3;
					
					haha.name = string($1->child->value);
					haha.varglobal = true;
					haha.arr=false;
					haha.regs=false;
					haha.regt=false;
					vars1.push_back(haha);
					fprintf (datafile, "%s: .word 0\n",$1->child->value);
					
					}
	|	
	 id TOKEN_LB int_literal TOKEN_RB{$$= new tok();
																	$$->child = $1;
																	temp2 = new tok();
																	temp2->name = strdup(" TOKEN_RB");
																	temp2->value = strdup(" ]");
																	temp3 = new tok();
																	temp3->name = strdup(" TOKEN_LB");
																	temp3->value = strdup(" [");
																	$1->sibling = temp3;
																	temp3->sibling = $3;
																	$3->sibling=temp2;
																	$$->name = strdup("");
																	$$->value = strdup("");
																	flag = 0;
																	for(int i = vars1.size()-1;i>=0;i--){
																	if(vars1[i].name.compare($1->child->value)==0){
																	cout<<"variable redefined"<<endl;
																	exit(0);
																	}
																	}
																	
																	numbers++;
																	ins = 3;
																	haha.name = string($1->child->value);
																	haha.varglobal = false;
																	haha.arr=true;
																	haha.regs=false;
																	haha.regt=false;
																	haha.arr_size=atoi($3->child->value);
																	vars1.push_back(haha);
																	if (atoi($3->child->value)<=0){cout<<"array index not valid in line:"<<yylineno;exit(0);}
																	fprintf (datafile, "%s: .space %d\n",$1->child->value,(atoi($3->child->value)*4));
																	fprintf (textfile, "\taddi $s0, $zero, 0\n\taddi $t0, $zero, 0\n\tsw $s0, %s($t0)\n",$1->child->value);
																	for(int i =1;i<atoi($3->child->value);i++){
																	fprintf (textfile, "\taddi $t0, $t0, 4\n\tsw $s0, %s($t0)\n",$1->child->value);
																	}
																	}

type :
		TOKEN_BOOLEANTYPE {	 $$ = new tok();
							 temp1 = new tok();
						     temp1->name = strdup(" TOKEN_BOOLEANTYPE"); 
							 temp1->value = strdup(" boolean");	
							 $$->child = temp1;
							 $$->name = strdup(" <type>"); 
							 $$->value = strdup(" <type>");							
							}
		| TOKEN_INTTYPE     {$$ = new tok();
							 temp1 = new tok();
						     temp1->name = strdup(" TOKEN_INTTYPE"); 
							 temp1->value = strdup(" int");	
							 $$->child = temp1;
							 $$->name = strdup(" <type>"); 
							 $$->value = strdup(" <type>");
							 }
							
							
id :
	TOKEN_ID {	
	
				$$ = new tok();
				temp1 = new tok();
				temp1->name = strdup(" TOKEN_ID"); 
				temp1->value = strdup($1);	
				$$->child = temp1;
				$$->name = strdup(" <id>"); 
				$$->value = strdup(" <id>");
				}

int_literal :
		TOKEN_HEXADECIMALCONST {$$ = new tok();
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_HEXADECIMALCONST"); 
								temp1->value = strdup($1);	
								$$->child = temp1;
								$$->name = strdup(" <int_literal>"); 
								$$->value = strdup(" <int_literal>");
								$$->location_type = 'i';
				}
		|TOKEN_DECIMALCONST {$$ = new tok();
							temp1 = new tok();
							temp1->name = strdup(" TOKEN_DECIMALCONST"); 
							temp1->value = strdup($1);	
							$$->child = temp1;
							$$->name = strdup(" <int_literal>"); 
							$$->value = strdup(" <int_literal>");
							$$->location_type = 'i';
							}


method_dec3 : 

			
			method_dec3 method_dec{$$ = new tok();
						$$->name = strdup("");
						$$->value = strdup("");					 
						$$->child = $1;
$1->sibling = $2;						
						}
			| method_dec{$$ = new tok();
						$$->name = strdup("");
						$$->value = strdup("");					 
						$$->child = $1; 
						}
			

method_dec :
		
		type method_dec2{$$ = new tok();
						$$->name = strdup(" <method_dec>");
						$$->value = strdup(" <method_dec>");					 
						$$->child = $1; 
						$1->sibling = $2;
							}
		|
		TOKEN_VOIDTYPE method_dec2{$$ = new tok();
									temp1 = new tok();
									temp1->name = strdup(" TOKEN_VOIDTYPE"); 
									temp1->value = strdup($1);	
									$$->child = temp1;
									$$->name = strdup(" <method_dec>");
									$$->value = strdup(" <method_dec>");
									temp1->sibling=$2;
							}
		

method_dec2 :
				TOKEN_MAINFUNC TOKEN_LP TOKEN_RP{fprintf (textfile, ".main\n");} block{
									$$ = new tok();
									temp1 = new tok();
									temp1->name = strdup(" TOKEN_MAINFUNC"); 
									temp1->value = strdup(" main");	
									$$->child = temp1;
									$$->name = strdup("");
									$$->value = strdup("");
									temp2 = new tok();
									temp2->name = strdup(" TOKEN_LP"); 
									temp2->value = strdup(" (");	
									temp1->sibling=temp2;							
									temp3 = new tok();
									temp3->name = strdup(" TOKEN_RP"); 
									temp3->value = strdup(" )");	
									temp2->sibling=temp3;
									temp3->sibling=$5;
									
									fprintf (textfile, "\tli $v0, 10\n\tsyscall\n");
									}					
															
				|
				id TOKEN_LP toop TOKEN_RP {fprintf (textfile, ".%s\n",$1->child->value);} block{
									$$ = new tok();
									$$->child = $1;
									$$->name = strdup("");
									$$->value = strdup("");
									temp2 = new tok();
									temp2->name = strdup(" TOKEN_LP"); 
									temp2->value = strdup(" (");	
									$1->sibling=temp2;							
									temp3 = new tok();
									temp3->name = strdup(" TOKEN_RP"); 
									temp3->value = strdup(" )");	
									temp2->sibling=$3;
									$3->sibling=temp3;
									temp3->sibling=$6;
									struct  f fun;
									fun.name = string($1->child->value);
									fun.has_args = true;
									fun.args=args2;
									funcs.push_back(fun);
									args2.clear();
									 fprintf (textfile,"\tjr $ra\n");
									
									}	
				|
				id TOKEN_LP TOKEN_RP{fprintf (textfile, ".%s\n",$1->child->value);} block{
									$$ = new tok();
									$$->child = $1;
									$$->name = strdup("");
									$$->value = strdup("");
									temp2 = new tok();
									temp2->name = strdup(" TOKEN_LP"); 
									temp2->value = strdup(" (");	
									$1->sibling=temp2;							
									temp3 = new tok();
									temp3->name = strdup(" TOKEN_RP"); 
									temp3->value = strdup(" )");	
									temp2->sibling=temp3;
									
									temp3->sibling=$5;
									
									struct  f fun;
									fun.name = string($1->child->value);
									fun.has_args = false;
									
									funcs.push_back(fun);
									fprintf (textfile,"\tjr $ra\n");
									}

toop :
				type id {
				$$= new tok();
				$$->child = $1;
				$1->sibling=$2;
				$$->name = strdup("");
				$$->value = strdup("");
				struct tdata re;
				if (strcmp($1->child->value," int")==0){
				re.type = 'i';
				}else{
				re.type='b';
				}
				args2.push_back(re);
				}
				|
				type id TOKEN_COMMA toop {
				$$= new tok();
				$$->child = $1;
				$1->sibling=$2;
				$$->name = strdup("");
				$$->value = strdup("");
				
				temp1 = new tok();
				temp1->name = strdup(" TOKEN_COMMA");
				temp1->value = strdup(" ,");
				$2->sibling = temp1;
				temp1->sibling=$4;
				
				if (strcmp($1->child->value," int")==0){
				re.type = 'i';
				}else{
				re.type='b';
				}
				args2.push_back(re);
				
				}
				

block :
		TOKEN_LCB var_dec2 statement2 TOKEN_RCB{
									$$=new tok();
									temp1 = new tok();
									temp1->name = strdup(" TOKEN_LCB");
									temp1->value = strdup(" {");
									$$->child=temp1;
									$$->name = strdup(" <block>");
									$$->value = strdup(" <block>");
									temp1->sibling=$2;
									$2->sibling=$3;
									
									temp3 = new tok();
									temp3->name = strdup(" TOKEN_RCB");
									temp3->value = strdup(" }");
									$3->sibling=temp3;
									}
var_dec2 :
		   {$$=new tok();
			$$->name = strdup(" ");
			$$->value = strdup(" ");}
		|	var_dec var_dec2{$$=new tok();
			$$->name = strdup(" ");
			$$->value = strdup(" ");
			$$->child=$1;
			$1 ->sibling=$2;}
		   
statement2 :
			
			{$$=new tok();
			$$->name = strdup(" ");
			$$->value = strdup(" ");}
			|
			statement statement2 {$$=new tok();
			$$->name = strdup(" ");
			$$->value = strdup(" ");
			$$->child=$1;
			$1 ->sibling=$2;}

toop4 :
		id{$$= new tok();
					$$->child = $1;
					$$->name = strdup("");
					$$->value = strdup("");
					
					
					flag = 0;
					for(int i = vars1.size()-1;i>=0;i--){
					if(vars1[i].name.compare($1->child->value)==0){
					cout<<"variable redefined"<<endl;
					exit(0);
					}
					}
					
					numbers++;
					ins = 3;
					
					haha.name = string($1->child->value);
					haha.varglobal = false;
					haha.arr=false;
					haha.regs=true;
					haha.regt=false;
					haha.value = vars;
					haha.reg_num=vars;
					vars1.push_back(haha);
					
					vars++;
					if(vars>7){
					cout <<"you cant define more than 8 non-global variables";
					exit(0);}
					fprintf (textfile, "\taddi $s%d, $zero, 0\n",vars-1);
					}
		|
		id TOKEN_COMMA toop4{$$= new tok();
					$$->child = $1;
					$$->name = strdup("");
					$$->value = strdup("");
					temp3 = new tok();
					temp3->name = strdup(" TOKEN_COMMA");
					temp3->value = strdup(" ,");
					$1->sibling = temp3;
					temp3->sibling = $3;
					
					flag = 0;
					for(int i = vars1.size()-1;i>=0;i--){
					if(vars1[i].name.compare($1->child->value)==0){
					cout<<"variable redefined"<<endl;
					exit(0);
					}
					}
					
					numbers++;
					ins = 3;
					
					haha.name = string($1->child->value);
					haha.varglobal = false;
					haha.arr=false;
					haha.regs=true;
					haha.regt=false;
					haha.value = vars;
					vars1.push_back(haha);
					haha.reg_num=vars;
					vars++;
					
					
					
					if(vars>7){
					cout <<"you cant define more than 8 non-global variables";
					exit(0);}
					fprintf (textfile, "\taddi $s%d, $zero, 0\n",vars-1);
					}
			
var_dec :
			type toop4 TOKEN_SEMICOLON{$$=new tok();
								 $$->child = $1;
								 temp1 = new tok();
								temp1->name = strdup(" TOKEN_SEMICOLON");
								temp1->value = strdup(" ;");
								 $1->sibling = temp1;
								 $$->name = strdup(" <var_dec>");
								$$->value = strdup(" <var_dec>");
								
								if(strcmp(" int",$1->child->value)==0){
									for(int i = vars1.size()-1;numbers>0;numbers--){
									vars1[i-(numbers-1)].type='i';
									}
									numbers=0;
									}else if(strcmp(" boolean",$1->child->value)==0)
									{
									for(int i = vars1.size()-1;numbers>0;numbers--){
									vars1[i-(numbers-1)].type='b';
									}
									numbers=0;
									}
								
								
								
								
								}
			

statement :
			location TOKEN_ASSIGNOP expr TOKEN_SEMICOLON
			{
			$$=new tok();
								 $$->child = $1;
								 temp1 = new tok();
								temp1->name = strdup(" TOKEN_ASSIGNOP");
								temp1->value = strdup($2);
								 $1->sibling = temp1;
								 temp1->sibling=$3;
								 $$->name = strdup(" <statement>");
								$$->value = strdup(" <statement>");
								 temp2= new tok();
								temp2->name = strdup(" TOKEN_SEMICOLON");
								temp2->value = strdup(" ;");
								$3->sibling=temp2;
								flag = -1;
								for (int i = vars1.size()-1;i>=0;i--){
								if(vars1[i].name.compare($1->child->child->value)==0){
								flag = i;
								break;
								}								
								}
								if(flag==-1){cout<<"variable "<<$1->child->child->value<<" is not defined"<<endl;
								exit(0);}
								if(vars1[flag].type!=$3->location_type){cout<<"variable types before and after assign operation are different"<<endl;
								
								exit(0);}
								
								if(vars1[flag].arr == true){
								
								
								fprintf (textfile, "\taddi $t2, $zero, %d\n",((atoi($1->child->sibling->sibling->child->value))*4));
								fprintf (textfile, "\tsw $t%d, %s($t2)\n",$3->exp_val,vars1[flag].name.c_str());
								
																						
								}else if(vars1[flag].varglobal == true){
								fprintf (textfile, "\tsw $t%d, %s\n",$3->exp_val,vars1[flag].name.c_str());
								
								}else if(vars1[flag].regs == true){
								fprintf (textfile, "\tsw $t%d, $s%d\n",$3->exp_val,vars1[flag].value);
								}
								
								
								
								
								}
			|
			method_call TOKEN_SEMICOLON{$$=new tok();
								 $$->child = $1;
								 $$->name = strdup(" <statement>");
								$$->value = strdup(" <statement>");
								 temp2= new tok();
								temp2->name = strdup(" TOKEN_SEMICOLON");
								temp2->value = strdup(" ;");
								$1->sibling=temp2;
}
			|
			TOKEN_IFCONDITION TOKEN_LP expr TOKEN_RP {
			fprintf (textfile, "\tbeq $t%d, $zero , ENDIF\n",$3->exp_val);
					
			}block{$$=new tok();
								 
								 $$->name = strdup(" <statement>");
								$$->value = strdup(" <statement>");
								temp1 = new tok();
								$$->child = temp1;
								temp1->name = strdup(" TOKEN_IFCONDITION");
								temp1->value = strdup(" if");
								temp2 = new tok();
								temp2->name = strdup(" TOKEN_LP");
								temp2->value = strdup(" (");
								 temp1->sibling=temp2;
								 temp2->sibling=$3;
								
								temp3 = new tok();
								temp3->name = strdup(" TOKEN_RP");
								temp3->value = strdup(" )");
								 $3->sibling=temp3;
								 temp3->sibling=$6;
								 fprintf (textfile, "ENDIF\n");
								 }
			
			|
			TOKEN_LOOP id TOKEN_ASSIGNOP expr TOKEN_COMMA expr{
			fprintf (textfile, "\taddi $t9, $zero, $t%d\n",$4->exp_val);
			fprintf (textfile, "\taddi $t8, $zero, $t%d\n",$6->exp_val);
			fprintf (textfile, "\tslti $t7, $t9, $t8\n");
			fprintf (textfile, "\tbne $t7, $zero, Loop\n");
			fprintf (textfile, "\tj ENDLOOP\n");
			fprintf (textfile, "LOOP\n");
			
			}
			block{$$=new tok();
								 
								 $$->name = strdup(" <statement>");
								$$->value = strdup(" <statement>");
								temp1 = new tok();
								$$->child = temp1;
								temp1->name = strdup(" TOKEN_LOOP");
								temp1->value = strdup(" for");
								temp2 = new tok();
								temp2->name = strdup(" TOKEN_ASSIGNOP");
								temp2->value = strdup($3);
								 temp1->sibling=$2;
								 $2->sibling=temp2;
								temp2->sibling=$4;
								temp3 = new tok();
								temp3->name = strdup(" TOKEN_COMMA");
								temp3->value = strdup(" ,");
								 $4->sibling=temp3;
								 temp3->sibling=$6;
								 $6->sibling=$8;
								 
								fprintf (textfile, "\taddi $t9, $t9, 1\n");
								
								fprintf (textfile, "\tslti $t7, $t9, $t8\n");
								fprintf (textfile, "\tbne $t7, $zero, Loop\n");
								 fprintf (textfile, "ENDLOOP NOP\n");
								}
			|
			TOKEN_RETURN TOKEN_SEMICOLON{$$=new tok();
								 
								 $$->name = strdup(" <statement>");
								$$->value = strdup(" <statement>");
								temp1 = new tok();
								$$->child = temp1;
								temp1->name = strdup(" TOKEN_RETURN");
								temp1->value = strdup(" return");
								 temp2= new tok();
								temp2->name = strdup(" TOKEN_SEMICOLON");
								temp2->value = strdup(" ;");
								temp1->sibling=temp2;}
			|
			TOKEN_RETURN expr TOKEN_SEMICOLON{$$=new tok();
								 
								 $$->name = strdup(" <statement>");
								$$->value = strdup(" <statement>");
								temp1 = new tok();
								$$->child = temp1;
								temp1->name = strdup(" TOKEN_RETURN");
								temp1->value = strdup(" return");
								temp1->sibling=$2;
								 temp2= new tok();
								temp2->name = strdup(" TOKEN_SEMICOLON");
								temp2->value = strdup(" ;");
								$2->sibling=temp2;}
			|
			TOKEN_BREAKSTMT TOKEN_SEMICOLON{$$=new tok();
								 
								 $$->name = strdup(" <statement>");
								$$->value = strdup(" <statement>");
								temp1 = new tok();
								$$->child = temp1;
								temp1->name = strdup(" TOKEN_BREAKSTMT");
								temp1->value = strdup(" break");
								temp2 = new tok();
								
								temp2->name = strdup(" TOKEN_SEMICOLON");
								temp2->value = strdup(" ;");
								temp1->sibling=temp2;}
			|
			TOKEN_CONTINUESTMT TOKEN_SEMICOLON{$$=new tok();
								 
								 $$->name = strdup(" <statement>");
								$$->value = strdup(" <statement>");
								temp1 = new tok();
								$$->child = temp1;
								temp1->name = strdup(" TOKEN_CONTINUESTMT");
								temp1->value = strdup(" continue");
								temp2 = new tok();
								
								temp2->name = strdup(" TOKEN_SEMICOLON");
								temp2->value = strdup(" ;");
								temp1->sibling=temp2;}
			|
			block{$$=new tok();
								 
								 $$->name = strdup(" <statement>");
								$$->value = strdup(" <statement>");
								
								$$->child = $1;}
			
			

method_call :
			method_name TOKEN_LP expr2 TOKEN_RP{$$=new tok();
								 $$->child = $1;
								 $$->name = strdup(" <method_call>");
								$$->value = strdup(" <method_call>");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_LP");
								temp1->value = strdup(" (");
								 $1->sibling=temp1;
								temp1->sibling=$3;
								temp2 = new tok();
								temp2->name = strdup(" TOKEN_RP");
								temp2->value = strdup(" )");
								 $3->sibling=temp2;
								 
								 flag = -1;
								 for(int i = funcs.size()-1;i>=0;i--){
								 if(funcs[i].name.compare($1->child->child->value)==0){
								 flag = i;
								 break;
								 }								 
								 }
								 if(flag == -1){
								 cout<<"function not defined"<<endl;
								 exit(0);
								 }
								 if(funcs[flag].has_args==false){
								 cout<<"wrong function call: function call should have no input arguments"<<endl;
								 exit(0);								 
								 }
								 temp1=$3->child;
								 for(int i = funcs[flag].args.size()-1;i>=0;i--){
								 if(temp3->location_type!=funcs[flag].args[i].type){
								 cout<<"wrong function call: argument types dont match"<<endl;
								 exit(0);
								 }
								 if(i!=0){temp1=temp1->sibling->sibling;}
								 }
								 fprintf (textfile,"\tjal %s\n",funcs[flag].name.c_str());
								}
			|
			method_name TOKEN_LP TOKEN_RP{$$=new tok();
								 $$->child = $1;
								 $$->name = strdup(" <method_call>");
								$$->value = strdup(" <method_call>");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_LP");
								temp1->value = strdup(" (");
								 $1->sibling=temp1;
								
								temp2 = new tok();
								temp2->name = strdup(" TOKEN_RP");
								temp2->value = strdup(" )");
								 temp1->sibling=temp2;
								 flag = -1;
								 for(int i = funcs.size()-1;i>=0;i--){
								 if(funcs[i].name.compare($1->child->child->value)==0){
								 flag = i;
								 break;
								 }								 
								 }
								 if(flag == -1){
								 cout<<"function not defined"<<endl;
								 exit(0);
								 }
								 if(funcs[flag].has_args==true){
								 cout<<"wrong function call: function call should have input arguments"<<endl;
								 exit(0);
								 
								 }
								  fprintf (textfile,"\tjal %s\n",funcs[flag].name.c_str());
								}
			|
			TOKEN_CALLOUT TOKEN_LP string_literal TOKEN_COMMA callout_arg TOKEN_RP{$$=new tok();
								 $$->name = strdup(" <method_call>");
								$$->value = strdup(" <method_call>");
								temp1 = new tok();
								$$->child = temp1;
								temp1->name = strdup(" TOKEN_CALLOUT");
								temp1->value = strdup(" callout");
								temp2 = new tok();
								temp2->name = strdup(" TOKEN_LP");
								temp2->value = strdup(" (");
								 temp1->sibling=temp2;
								 temp2->sibling=$3;
								
								temp3 = new tok();
								temp3->name = strdup(" TOKEN_RP");
								temp3->value = strdup(" )");
								 
								 temp4 = new tok();
								temp4->name = strdup(" TOKEN_COMMA");
								temp4->value = strdup(" ,");
								$3->sibling=temp4;
								temp4->sibling=$5;
								$5->sibling=temp3;
								 
								
			
			}

string_literal :TOKEN_STRINGCONST{$$=new tok();
								 
								 $$->name = strdup(" <string_literal>");
								$$->value = strdup(" <string_literal>");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_STRINGCONST"); 
								temp1->value = strdup($1);	
								$$->child = temp1;}

callout_arg :callout_arg2
			{$$= new tok();
				$$->child = $1;
				
				$$->name = strdup("");
				$$->value = strdup("");
			}	
			|
			callout_arg2 TOKEN_COMMA callout_arg{$$= new tok();
				$$->child = $1;
				
				$$->name = strdup("");
				$$->value = strdup("");
				
				temp1 = new tok();
				temp1->name = strdup(" TOKEN_COMMA");
				temp1->value = strdup(" ,");
				$1->sibling = temp1;
				temp1->sibling=$3;}
			
callout_arg2 :
			expr{$$= new tok();
				$$->child = $1;
				
				$$->name = strdup("");
				$$->value = strdup("");
			}
			|
			string_literal
			{$$= new tok();
				$$->child = $1;
				
				$$->name = strdup("");
				$$->value = strdup("");
			}
			

			
expr2 : expr {$$=new tok();
								 $$->child = $1;
								 $$->name = strdup("");
								$$->value = strdup("");
								$$->exp_val = $1->exp_val;
								$$->location_type=$1->location_type;
								
}
		|
		expr TOKEN_COMMA expr2{$$=new tok();
								 $$->child = $1;
								 $$->name = strdup("");
								$$->value = strdup("");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_COMMA");
								temp1->value = strdup(" ,");
								 $1->sibling=temp1;
								temp1->sibling=$3;}

method_name : id{$$=new tok();
								 $$->child = $1;
								 $$->name = strdup(" <method_name>");
								$$->value = strdup(" <method_name>");
}
expr :
		expr3{$$=new tok();
								 $$->child = $1;
								 $$->name = strdup("");
								$$->value = strdup("");
								$$->exp_type = $1->exp_type;
								$$->exp_val = $1->exp_val;
								$$->location_type=$1->location_type;
								$$->cv=$1->cv;
								$$->gr=$1->gr;}
		|
		expr3 bin_op expr{$$=new tok();
								 $$->child = $1;
								 $$->name = strdup(" <expr>");
								$$->value = strdup(" <expr>");
								$1->sibling=$2;
								$2->sibling=$3;
								/*code generation*/
								if ($1->location_type!=$3->location_type){
								cout <<" expressions before and after bin_op have different types"<<endl;
								exit(0);
								}
								
								if ($1->location_type=='c'||$3->location_type=='c'){
								cout <<" cant perform bin_op on char"<<endl;
								exit(0);
								}
								
								if(!strcmp($2->child->child->value,"+")){
								if ($1->location_type=='b'){
								cout<<"cant perform + operation on boolean"<<endl;
								exit(0);
								}
								fprintf (textfile, "\taddi $t%d, $t%d, $t%d\n",$1->exp_val,$1->exp_val,$3->exp_val);
								$$->exp_val=$1->exp_val;
								$$->location_type = $1->location_type;
								}
								if(!strcmp($2->child->child->value,"*")){
								if ($1->exp_type=='b'){
								cout<<"cant perform * operation on boolean"<<endl;
								exit(0);
								}
								fprintf (textfile, "\tmul $t%d, $t%d, $t%d\n",$1->exp_val,$1->exp_val,$3->exp_val);
								$$->exp_val=$1->exp_val;
								$$->location_type = $1->location_type;
								}
								if(!strcmp($2->child->child->value,"-")){
								if ($1->location_type=='b'){
								cout<<"cant perform - operation on boolean"<<endl;
								exit(0);
								}
								fprintf (textfile, "\tsub $t%d, $t%d, $t%d\n",$1->exp_val,$1->exp_val,$3->exp_val);
								$$->exp_val=$1->exp_val;
								$$->location_type = $1->location_type;
								}
								if(!strcmp($2->child->child->value,"/")){
								if ($1->exp_type=='b'){
								cout<<"cant perform / operation on boolean"<<endl;
								exit(0);
								}
								
								fprintf (textfile, "\tdiv $t%d, $t%d, $t%d\n",$1->exp_val,$1->exp_val,$3->exp_val);
								$$->exp_val=$1->exp_val;
								$$->location_type = $1->location_type;
								}
								if(!strcmp($2->child->child->value,"%")){
								if ($1->exp_type=='b'){
								cout<<"cant perform % operation on boolean"<<endl;
								exit(0);
								}
								fprintf (textfile, "\tdiv $t%d, $t%d\n",$1->exp_val,$3->exp_val);
								fprintf (textfile, "\tmfhi $t%d\n",$1->exp_val);
								$$->exp_val=$1->exp_val;
								$$->location_type = $1->location_type;
								}
								if(!strcmp($2->child->child->value,"<")){
								if ($1->location_type=='b'){
								cout<<"cant perform < operation on boolean"<<endl;
								exit(0);
								}
								fprintf (textfile, "\tslt $t%d, $t%d, $t%d\n",$1->exp_val,$1->exp_val,$3->exp_val);
								$$->exp_val=$1->exp_val;
								$$->location_type = 'b';}
								if(!strcmp($2->child->child->value,">")){
								if ($1->location_type=='b'){
								cout<<"cant perform > operation on boolean"<<endl;
								exit(0);
								}
								fprintf (textfile, "\tslt $t%d, $t%d, $t%d\n",$1->exp_val,$3->exp_val,$1->exp_val);
								$$->exp_val=$1->exp_val;
								$$->location_type = 'b';}
								if(!strcmp($2->child->child->value,">=")){
								if ($1->location_type=='b'){
								cout<<"cant perform >= operation on boolean"<<endl;
								exit(0);
								}
								fprintf (textfile, "\tslt $t%d, $t%d, $t%d\n",$1->exp_val,$1->exp_val,$3->exp_val);
								fprintf (textfile, "\tslt $t9, $zero , $t%d\n",$1->exp_val);
								fprintf (textfile, "\tslt $t8, $t%d , $zero\n",$1->exp_val);
								fprintf (textfile, "\tor $t9, $t9 , $t8\n");
								fprintf (textfile, "\txori $t%d, $t9 , 1 \n",$1->exp_val);
								$$->exp_val=$1->exp_val;
								$$->location_type = 'b';
								}
								if(!strcmp($2->child->child->value,"<=")){
								if ($1->location_type=='b'){
								cout<<"cant perform <= operation on boolean"<<endl;
								exit(0);
								}
								fprintf (textfile, "\tslt $t%d, $t%d, $t%d\n",$1->exp_val,$3->exp_val,$1->exp_val);
								fprintf (textfile, "\tslt $t9, $zero , $t%d\n",$1->exp_val);
								fprintf (textfile, "\tslt $t8, $t%d , $zero\n",$1->exp_val);
								fprintf (textfile, "\tor $t9, $t9 , $t8\n");
								fprintf (textfile, "\txori $t%d, $t9 , 1 \n",$1->exp_val);
								$$->exp_val=$1->exp_val;
								$$->location_type = 'b';
								}
								if(!strcmp($2->child->child->value,"==")){
								
								/*fprintf (textfile, "\tslt $t%d, $t%d, $t%d\n",$1->exp_val,$3->exp_val,$1->exp_val);
								
								fprintf (textfile, "\tslt $t9, $zero , $t%d\n",$1->exp_val);
								fprintf (textfile, "\tslt $t8, $t%d , $zero\n",$1->exp_val);
								fprintf (textfile, "\tor $t9, $t9 , $t8\n");
								fprintf (textfile, "\txori $t%d, $t9 , 1 \n",$1->exp_val);
								
								$$->exp_val=$1->exp_val;
								$$->location_type = 'b';*/}
								if(!strcmp($2->child->child->value,"!=")){
								fprintf (textfile, "\tslt $t9, $t%d, $t%d\n",$3->exp_val,$1->exp_val);
								fprintf (textfile, "\tslt $t8, $t%d, $t%d\n",$1->exp_val,$3->exp_val);
								fprintf (textfile, "\txori $t%d, $t9 , $t8 \n",$1->exp_val);
								$$->exp_val=$1->exp_val;
								$$->location_type = 'b';
								}
								if(!strcmp($2->child->child->value,"||")){
								if ($1->location_type=='v'){
								cout<<"cant perform || operation on integer"<<endl;
								exit(0);
								}
								$$->exp_val=($1->exp_val||$3->exp_val);
								$$->location_type = 'b';}
								if(!strcmp($2->child->child->value,"&&")){
								if ($1->location_type=='v'){
								cout<<"cant perform && operation on integer"<<endl;
								exit(0);
								}
								$$->exp_val=($1->exp_val&&$3->exp_val);
								$$->location_type = 'b';
								
								}
								}
expr3 :
		location {$$=new tok();	 
								 $$->name = strdup(" <expr>");
								$$->value = strdup(" <expr>");
								
								$$->child = $1;
								$$->exp_val=$1->exp_val;
								flag = -1;
								for (int i = vars1.size()-1;i>=0;i--){
								if(vars1[i].name.compare($1->child->child->value)==0){
								flag = i;
								break;
								}								
								}
								if(flag==-1){cout<<"variable "<<$1->child->child->value<<" is not defined"<<endl;
								exit(0);}
								if(vars1[flag].regs == true){
								fprintf (textfile, "\taddi $t%d, $zero, $s%d\n",tvars,vars1[flag].reg_num);
								$$->exp_val = tvars;
								$$->location_type=vars1[flag].type;
								tvars++;
								if(tvars>=9){
								cout<<"numbers of allowed expressions exceeded!"<<endl;
								exit(0);
								}
								}
								if(vars1[flag].arr == true){
								fprintf (textfile, "\taddi $t9, $zero, %d\n",(atoi($1->child->sibling->sibling->child->value)*4));
								
								fprintf (textfile, "\tlw $t%d, %s($t9)\n",tvars,vars1[flag].name.c_str());
								$$->exp_val = tvars;
								$$->location_type=vars1[flag].type;
								tvars++;
								if(tvars>=9){
								cout<<"numbers of allowed expressions exceeded!"<<endl;
								exit(0);}
								}

								if(vars1[flag].varglobal == true){
								fprintf (textfile, "\taddi $t%d, $zero, $s%s\n",tvars,vars1[flag].name.c_str());
								$$->exp_val = tvars;
								$$->location_type=vars1[flag].type;
								tvars++;
								if(tvars>=9){
								cout<<"numbers of allowed expressions exceeded!"<<endl;
								exit(0);
								}
								}
								}
		|
		method_call{$$=new tok();
								 
								 $$->name = strdup(" <expr>");
								$$->value = strdup(" <expr>");
								
								$$->child = $1;}
		|
		literal {$$=new tok();
								 
								 $$->name = strdup(" <expr>");
								$$->value = strdup(" <expr>");
								
								$$->child = $1;
								$$->exp_val = $1->exp_val;
								$$->location_type=$1->location_type;
								
								}
		
		|
		TOKEN_ARITHMATICOP4 expr3{$$=new tok();
								 
								$$->name = strdup(" <expr>");
								$$->value = strdup(" <expr>");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_ARITHMATICOP5");
								temp1->value = strdup(" -");
								$$->child = temp1;
								temp1->sibling=$2;
								if($2->location_type=='c'||$2->location_type=='b'){
								cout<<"cant use operation - on boolean or character"<<endl;exit(0);
								}
								
								fprintf (textfile,"\tsub $t%d, $zero, $t%d\n",$2->exp_val,$2->exp_val);
								$$->exp_val = $2->exp_val;
								$$->location_type=$2->location_type;
								
								
								
								}
		|
		TOKEN_LOGICOP expr3{$$=new tok();
								 
								 $$->name = strdup(" <expr>");
								$$->value = strdup(" <expr>");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_LOGICOP");
								temp1->value = strdup(" !");
								$$->child = temp1;
								temp1->sibling=$2;
								
								if($2->location_type=='i'||$2->location_type=='c'){
								cout<<"cant use operation ! on integer or character"<<endl;exit(0);
								}
								
								fprintf (textfile, "\tslt $t9, $zero , $t%d\n",$2->exp_val);
								fprintf (textfile, "\tslt $t8, $t%d , $zero\n",$2->exp_val);
								fprintf (textfile, "\tor $t9, $t9 , $t8\n");
								fprintf (textfile, "\txori $t%d, $t9 , 1 \n",$2->exp_val);
								$$->exp_val = $2->exp_val;
								$$->location_type=$2->location_type;
								
								}
		|
		TOKEN_LP expr TOKEN_RP{$$=new tok();
								 
								 $$->name = strdup(" <expr>");
								$$->value = strdup(" <expr>");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_LP");
								temp1->value = strdup(" (");
								$$->child = temp1;
								temp1->sibling=$2;
								temp2 = new tok();
								temp2->name = strdup(" TOKEN_RP");
								temp2->value = strdup(" )");
								$2->sibling=temp2;
								
								$$->exp_val = $2->exp_val;
								$$->location_type=$2->location_type;
								
								}						

location :
			id{$$=new tok();
								 
								 $$->name = strdup(" <location>");
								$$->value = strdup(" <location>");
								
								$$->child = $1;
								$$->location_type = 'v';
								/*
								
								flag=0;
								for(;flag<8;flag ++){
								if (reg[flag].compare($1->child->value)==0)
								break;
								}
								if (flag==8)
								{
								flag2 =0;
								for(flag =0;flag<vars1.size();flag ++){
								if (vars1[flag].name.compare($1->child->value)==0){
								flag2 = 1;
								break;
								}
								}
								if(flag2==0)
								{cout<<"variable "<<$1->child->value<<" not defined"<<endl;exit(0);}
								else{$$->exp_val=flag2;}
								}
								else{
								$$->exp_val=flag;}
								
								*/
								
								
								
								
								}
			|
			id TOKEN_LB int_literal TOKEN_RB {$$= new tok();
																	$$->child = $1;
																	temp2 = new tok();
																	temp2->name = strdup(" TOKEN_RB");
																	temp2->value = strdup(" ]");
																	temp3 = new tok();
																	temp3->name = strdup(" TOKEN_LB");
																	temp3->value = strdup(" [");
																	$1->sibling = temp3;
																	temp3->sibling = $3;
																	$3->sibling=temp2;
																	$$->name = strdup(" <location>");
																	$$->value = strdup("<location>");
																	$$->location_type = 'a';
																	
																	flag = -1;
								for (int i = vars1.size()-1;i>=0;i--){
								if(vars1[i].name.compare($1->child->value)==0){
								flag = i;
								break;
								}								
								}
								
								if(vars1[flag].arr_size<=atoi($3->child->value)){cout<<"array index out of range"<<endl;
								exit(0);}
																	
																	
																/*	flag2 =0;
								for(flag =0;flag<arrs.size();flag ++){
								if (arrs[flag].compare($1->child->value)==0){
								flag2 = 1;
								break;
								}
								}
								if(flag2==0)
								{cout<<"variable "<<$1->child->value<<" not defined"<<endl;exit(0);}
								else{$$->exp_val=flag2;}
																	*/}

literal : 
		int_literal{$$=new tok();
								 
								 $$->name = strdup("< literal>");
								$$->value = strdup("< literal>");
								$$->child = $1;
								
								fprintf (textfile, "\taddi $t%d, $zero, %d\n",tvars,atoi($1->child->value));
								$$->exp_val = tvars;
								$$->location_type='i';
								tvars++;
								if(tvars>=9){
								cout<<"numbers of allowed expressions exceeded!"<<endl;
								exit(0);
								}
								
								
								
								}
		|
		char_literal{$$ = new tok();	
								$$->child = $1;
								$$->name = strdup(" <literal>"); 
								$$->value = strdup(" <literal>");
								
								
								fprintf (textfile, "\taddi $t%d, $zero, %d\n",tvars,*($1->child->value));
								$$->exp_val = tvars;
								$$->location_type='c';
								tvars++;
								if(tvars>=9){
								cout<<"numbers of allowed expressions exceeded!"<<endl;
								exit(0);
								}
								
				}
		|
		bool_literal{$$ = new tok();	
								$$->child = $1;
								$$->name = strdup(" <literal>"); 
								$$->value = strdup(" <literal>");
								
								
								fprintf (textfile, "\taddi $t%d, $zero, %d\n",tvars,atoi($1->child->value));
								$$->exp_val = tvars;
								$$->location_type='b';
								tvars++;
								if(tvars>=9){
								cout<<"numbers of allowed expressions exceeded!"<<endl;
								exit(0);
								}
								
				}

char_literal :TOKEN_CHARCONST {$$ = new tok();
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_CHARCONST"); 
								temp1->value = strdup($1);	
								$$->child = temp1;
								$$->name = strdup(" <char_literal>"); 
								$$->value = strdup(" <char_literal>");
				}

bool_literal :TOKEN_BOOLEANCONST {$$ = new tok();
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_BOOLEANCONST"); 
								temp1->value = strdup($1);	
								$$->child = temp1;
								$$->name = strdup(" <bool_literal>"); 
								$$->value = strdup(" <bool_literal>");
				}

bin_op :
		arith_op{$$=new tok();
								 
								 $$->name = strdup(" <bin_op>");
								$$->value = strdup(" <bin_op>");
								
								$$->child = $1;}
		|
		rel_op{$$=new tok();
								 
								 $$->name = strdup(" <bin_op>");
								$$->value = strdup(" <bin_op>");
								
								$$->child = $1;}
		|
		eq_op{$$=new tok();
								 
								 $$->name = strdup(" <bin_op>");
								$$->value = strdup(" <bin_op>");
								
								$$->child = $1;}
		|
		cond_op{$$=new tok();
								 
								 $$->name = strdup(" <bin_op>");
								$$->value = strdup(" <bin_op>");
								
								$$->child = $1;}


arith_op :
		TOKEN_ARITHMATICOP1{$$=new tok();
								 
								 $$->name = strdup(" <arith_op>");
								$$->value = strdup(" <arith_op>");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_ARITHMATICOP1"); 
								temp1->value = strdup($1);	
								$$->child = temp1;}
		|
		TOKEN_ARITHMATICOP2{$$=new tok();
								 
								 $$->name = strdup(" <arith_op>");
								$$->value = strdup(" <arith_op>");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_ARITHMATICOP2"); 
								temp1->value = strdup($1);	
								$$->child = temp1;}
		|
		TOKEN_ARITHMATICOP3{$$=new tok();
								 
								 $$->name = strdup(" <arith_op>");
								$$->value = strdup(" <arith_op>");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_ARITHMATICOP3"); 
								temp1->value = strdup($1);	
								$$->child = temp1;}
		|
		TOKEN_ARITHMATICOP4{$$=new tok();
								 
								 $$->name = strdup(" <arith_op>");
								$$->value = strdup(" <arith_op>");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_ARITHMATICOP4"); 
								temp1->value = strdup($1);	
								$$->child = temp1;}
		|
		TOKEN_ARITHMATICOP5{$$=new tok();
								 
								 $$->name = strdup(" <arith_op>");
								$$->value = strdup(" <arith_op>");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_ARITHMATICOP5"); 
								temp1->value = strdup($1);	
								$$->child = temp1;}

rel_op :
		TOKEN_RELATIONOP{$$=new tok();
								 
								 $$->name = strdup(" <rel_op>");
								$$->value = strdup(" <rel_op>");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_RELATIONOP"); 
								temp1->value = strdup($1);	
								$$->child = temp1;}
eq_op :TOKEN_EQUALITYOP{$$=new tok();
								 
								 $$->name = strdup(" <eq_op>");
								$$->value = strdup(" <eq_op>");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_EQUALITYOP"); 
								temp1->value = strdup($1);	
								$$->child = temp1;}
cond_op :TOKEN_CONDITIONOP{$$=new tok();
							
								 $$->name = strdup(" <cond_op>");
								$$->value = strdup(" <cond_op>");
								temp1 = new tok();
								temp1->name = strdup(" TOKEN_CONDITIONOP"); 
								temp1->value = strdup($1);	
								$$->child = temp1;}	
%%










int main(int argc , char** argv) {
numbers=0;
ins=0;
vars=0;
tvars=0;
textfile = fopen ("textfile","w");
datafile = fopen ("datafile","w");

	fprintf (datafile, ".data\n");
	fprintf (textfile, ".text\n");
  FILE * fr = fopen("a.txt" , "r");
	if(!fr)
		cout << "could not open file" << endl;
  yyin = fr;
  yyparse();
  //cout<<"Analyzer Output (print by Token_Name):"<<endl;
 // preOrder(root);
  //cout<<endl<<endl<<"Analyzer Output (print by Token_Value):"<<endl;
  //preOrder2(root);
    
	//cout << endl;
}

void yyerror(const char *s) {
    fprintf(stderr,"Error | Line: %d\n%s\n",yylineno,s);
}

void yyerror2(int a) {
    fprintf(stderr, "%d\n", a);
}

void preOrder(struct tok *node){


    cout<<node->name<<" ";


  if(node->child!=NULL) preOrder(node->child);
  if(node->sibling!=NULL) preOrder(node->sibling);
  return;
}
void preOrder2(struct tok *node){


    cout<<node->value<<" ";


  if(node->child!=NULL) preOrder2(node->child);
  if(node->sibling!=NULL) preOrder2(node->sibling);
  return;
}
void tree(struct tok *node){}



















