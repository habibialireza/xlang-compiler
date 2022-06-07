%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    void yyerror(char *);
    int yylex(void);
    void yyerror2(int );

    double sym[52];
    int init[52];
%}

%union{
double dd;
char c;
}
%token  INTEGER VARIABLE
%token SIN COS TAN COT EXP LN
%type <dd> expression INTEGER
%type <c> VARIABLE
%left '+' '-'
%left '*' '/'
%right '^'
%nonassoc UMINUS

%%

program:
        program statement '\n'
        | /* NULL */
        ;

statement:
        expression                      { printf("%lf\n", $1); }
        | VARIABLE '=' expression       { sym[$1] = $3; init [$1] = 11; }
        ;

expression:
        INTEGER                         /* default action { $$ = $1; }*/
        | VARIABLE                      { if (init[$1] !=11) {yyerror("uninitialized variable");
        						     exit(0);}
        						     else{
        						     $$ = sym[$1];} }
        | expression '+' expression     { $$ = $1 + $3; }
        | expression '-' expression     { $$ = $1 - $3; }
        | expression '^' expression	{ $$ = pow($1 ,$3); }
        | expression '*' expression     { $$ = $1 * $3; }
        | SIN '(' expression ')'	{ $$ = sin($3); }
	| COS '(' expression ')'	{ $$ = cos($3); }
	| TAN '(' expression ')'	{ $$ = tan($3); }
	| COT '(' expression ')'	{ $$ = 1/tan($3); }
	| EXP '(' expression ')'	{ $$ = exp($3); }
	| LN '(' expression ')'	{ $$ = log10($3); }
        | expression '/' expression {
            if ($3 == 0) {
                yyerror ("division by zero"); exit(0);
            }
            else
                $$ = $1 / $3; }
        | '-' expression %prec UMINUS   { $$ = -$2;}
        | '(' expression ')'            { $$ = $2; }
        ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

void yyerror2(int a) {
    fprintf(stderr, "%d\n", a);
}

int main(void) {
   // freopen ("a.txt", "r", stdin);  //a.txt holds the expression
    yyparse();
}
