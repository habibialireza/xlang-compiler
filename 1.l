%{
  #include <stdio.h>
  #include <iostream>
  using namespace std;
  #include "2.tab.h"
  int linenum = 1;
%}



%option noyywrap
%option yylineno


%%

"//".*\n   /*ignore*/
boolean  {yylval.c = strdup(yytext);
          return TOKEN_BOOLEANTYPE;}
break    {yylval.c = strdup(yytext);
          return TOKEN_BREAKSTMT;}
callout  {yylval.c = strdup(yytext);  
          return TOKEN_CALLOUT;}
class    {yylval.c = strdup(yytext);    
          return TOKEN_CLASS;}
continue {yylval.c = strdup(yytext);     
          return TOKEN_CONTINUESTMT;}
else     {yylval.c = strdup(yytext);   
          return TOKEN_ELSECONDITION;}
false    {yylval.c = strdup(yytext);    
          return TOKEN_BOOLEANCONST;}
for      {yylval.c = strdup(yytext);    
          return TOKEN_LOOP;}
if       {yylval.c = strdup(yytext);   
          return TOKEN_IFCONDITION;}
int      {yylval.c = strdup(yytext);  
          return TOKEN_INTTYPE;}
return   {yylval.c = strdup(yytext);  
          return TOKEN_RETURN;}
true     {yylval.c = strdup(yytext);    
          return TOKEN_BOOLEANCONST;}
void     {yylval.c = strdup(yytext);    
          return TOKEN_VOIDTYPE;}
Program  {yylval.c = strdup(yytext);     
          return TOKEN_PROGRAMCLASS;}
main     {yylval.c = strdup(yytext);     
          return TOKEN_MAINFUNC;}

[a-zA-Z][_a-zA-Z0-9]{0,31}	   	{yylval.c = strdup(yytext); 
									return TOKEN_ID;}

									
									
"%"     {yylval.c = strdup(yytext);
         return TOKEN_ARITHMATICOP1;}
"*"     {yylval.c = strdup(yytext);
         return TOKEN_ARITHMATICOP2;}
"/"     {yylval.c = strdup(yytext);
         return TOKEN_ARITHMATICOP3;}
"-"     {yylval.c = strdup(yytext);
         return TOKEN_ARITHMATICOP4;}
"+"     {yylval.c = strdup(yytext);
         return TOKEN_ARITHMATICOP5;}




"="     {yylval.c = strdup(yytext);  
         return TOKEN_ASSIGNOP;}
"-="    {yylval.c = strdup(yytext);       
         return TOKEN_ASSIGNOP;}
"+="    {yylval.c = strdup(yytext);
         return TOKEN_ASSIGNOP;}
"!="    {yylval.c = strdup(yytext);  
         return TOKEN_EQUALITYOP;}
"=="    {yylval.c = strdup(yytext);
         return TOKEN_EQUALITYOP;}
"<="    {yylval.c = strdup(yytext);  
         return TOKEN_RELATIONOP;}
">="    {yylval.c = strdup(yytext);  
         return TOKEN_RELATIONOP;}
"<"     {yylval.c = strdup(yytext);
         return TOKEN_RELATIONOP;}
">"     {yylval.c = strdup(yytext);
         return TOKEN_RELATIONOP;}
"&&"    {yylval.c = strdup(yytext);  
         return TOKEN_CONDITIONOP;}
"||"    {yylval.c = strdup(yytext);  
         return TOKEN_CONDITIONOP;}
"!"     {yylval.c = strdup(yytext);
         return TOKEN_LOGICOP;}
"{"     {yylval.c = strdup(yytext);
         return TOKEN_LCB;}
"}"     {yylval.c = strdup(yytext);
         return TOKEN_RCB;}
"["     {yylval.c = strdup(yytext);
         return TOKEN_LB;}
"]"     {yylval.c = strdup(yytext);
         return TOKEN_RB;}
"("     {yylval.c = strdup(yytext);
         return TOKEN_LP;}
")"     {yylval.c = strdup(yytext);
         return TOKEN_RP;}
";"     {yylval.c = strdup(yytext);
         return TOKEN_SEMICOLON;}
","     {yylval.c = strdup(yytext);
         return TOKEN_COMMA;}
\n      /*ignore*/
\t      /*ignore*/
" "     /*ignore*/
\'(\\.|[^\\'\n])*\'  { yylval.c = strdup(yytext);   
					   return TOKEN_CHARCONST; } /* Character constants */
\"(\\.|[^\\"\n])*\" { yylval.c = strdup(yytext);   
                      return TOKEN_STRINGCONST; } /* String constants */
-?0x0+ {yylval.c = strdup(yytext);  
        return TOKEN_HEXADECIMALCONST;}
-?0x0*[a-fA-F1-9][a-fA-F0-9]{0,7} {yylval.c = strdup(yytext);   
                                   return TOKEN_HEXADECIMALCONST; }



-?[0-9]+  {
			long long int num = atoll(yytext);
			if(num > 2147483647 || num < -2147483647) {
			cout << "out of range INTEHER in line " << yylineno << endl; exit(-1);;
			}
		 else {
			   yylval.c = strdup(yytext); return TOKEN_DECIMALCONST;
			}
		}



%% 
