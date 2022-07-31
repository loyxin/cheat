~f~ infix 	//f postfix		f@ prefix
1/2 ~N~ 10		1/2 //N[#,10] &
N[#,10]&@ 1/2 or N[#, 10]& /@ 1/2
# = # ##=#1,#2,#3,....
Times[#[[1]], #[[2]]] & /@ Tuples[Range[100, 999], {2}]

/@ Map[f, expr] f/@expr = f[expr] f/@{1,2,3}={f[1], f[2], f[3]} f@{1,2,3} = f[{1,2,3}]
//@	MapAll[f,expr]	全部映射到最后一层 f//@ {1, 2, 3} = g[{g[1], g[2], g[3]}]
@@ Apply[f,expr] f@@{1,2,3,4} = f[1,2,3,4]
@@@ Apply[f,expr,{1}] f@@{{1,2},{3,4}} ={f[1,2],f[3,4]}

expr1/.expr2	ReplaceAll[expr1,expr2]
expr1//.expr2	ReplaceRepeated[expr1,expr2]
expr1?expr2	PatternTest[expr1,expr2]  函数的定义

f[x_ /; EvenQ[x]] := x/2;
f[x_?EvenQ] := x/2;

{x, x, x} /. x :> RandomReal[]
{x, x, x}/. x-> RandomReal[]

Fold[f,x,{a1,a2,...}] f[f[x,a1],a2]
FoldList[f,x,{a1,a2}] = {x, f[x,a1],f[f[x,a1],a2]}
Nest[f,expr, n]  f[f[f[f[expr]]]]

g /: f[g[x_]] := h[x] UpValues[g]  {HoldPattern[f[g[x_]]] :> h[x]}
f[0]:=1 f[1]:=2 f[n_Integer] :=n*f[n-1] DownValues[f]

{{{
20`20 H*20 with high precision of 20 digits*L
Precision[Sqrt[2]] infinite
Precision[Sqrt[2.]] MachinePrecision
用 num`n 直接输入一个精度为 n 位的数值，用 num``a 直接输入一个准确度为 a 位的数值：
机器精度数包含的位数通常略低于16，对应于确切的53比特：transform 2 bit to 10 bit
<<filename	Get["filename"]

expr1@*expr2	Composition[expr1,expr2] f@*g@*h@x  f[g[h[x]]] similarily f@g@h@x
expr1/*expr2	RightComposition[expr1,expr2]
Composition[f1,f2,f3,…] 表示函数 f1、f2、f3、… 的复合.

expr1<>expr2<>expr3	StringJoin[expr1,expr2,expr3]
expr1===expr2	SameQ[expr1,expr2]
expr1=!=expr2	UnsameQ[expr1,expr2]
a**b**c 给出乘法的不可交换的一般结合形式.
}}}


## function

Partition[list,n,d,{Subscript[k, L],Subscript[k, R]}] 
specifies that the first element of list should appear at position Subscript[k, L] in the first sublist, and the last element of list should appear at or after position Subscript[k, R] in the last sublist. If additional elements are needed, Partition fills them in by treating list as cyclic. 

Reverse 对角转置 列表从后往前
Most[expr]
gives expr with the last element removed.

Tuples[list, n] element from the list  length^n {, , } n
Tuples[{1,2}, 3]{ {1,1,1}, ...} 8


Range[1000]~Select~PrimeQ~Take~3//Total//ToString
