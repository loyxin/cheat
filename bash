# var
TEST=TEMP
TEMP="test"
echo ${!TEST} # test echo $TEST # TEMP
``：命令替换
""：弱引用，可以实现变量和命令的替换。
'': 强引用，不完成变量替换
x=*
echo $x # all
echo "$x" # *
echo '$x' # $x

exec 打开文件描述符

exec [n]> filename
exec [n]<> filename
n > file	将文件描述符为 n 的文件重定向到 file。
n >> file	将文件描述符为 n 的文件以追加的方式重定向到 file。
n >& m	将输出文件 m 和 n 合并。
n <& m	将输入文件 m 和 n 合并。
<< tag	将开始标记 tag 和结束标记 tag 之间的内容作为输入。
需要注意的是文件描述符 0 通常是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）。

# To implement a for loop:
for file in *;
do
    echo $file found;
done

for var in $list ## for(auto i in list)
for var in "$list" # 解析为字符串

echo a{b, c, d}e # abe, ace, ade
echo {0..10}
# To implement a case command:
case "$1"
in
    0) echo "zero found";;
    1) echo "one found";;
    2) echo "two found";;
    3*) echo "something beginning with 3 found";;
esac

# input
read name
echo "hello $name."

Weak: uses double quotes: " # expand your argument
Strong: uses single quotes:' # not expand

$# 参数个数
$0 当前脚本的文件名
$* 传递给脚本或函数的所有参数
$@ 传递给脚本或函数的所有参数
但是当它们被双引号(" ")包含时，"$*" 会将所有的参数作为一个整体，以"$1 $2 … $n"的形式输出所有参数；"$@" 会将各个参数分开，以"$1" "$2" … "$n" 的形式输出所有参数。


$$ 当前Shell进程的ID
$? 上个命令的退出状态

单引号变量var='test' ，只能原样输出，变量无效
双引号变量var="my name is ${name}"，变量有效 可出现转义符
`` 执行命令
echo ${#var} 加#获取长度 输出为4
提取子字符串
1:4 从第2个开始 往后截取4个字符
::4 从第一个字符开始 往后截取4个字符
echo ${name:1:4} echo ${name::4}


${#pattern}
pattern 多长
