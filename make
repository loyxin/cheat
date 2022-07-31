$@  表示目标文件
$^  表示所有的依赖文件
$<  表示第一个依赖文件
$+ 这个变量很像“$^”，也是所有依赖目标的集合。只是它不去除重复的依赖目标。
$?  表示比目标还要新的依赖文件列表

$% 仅当目标是函数库文件中，表示规则中的目标成员名。例如，如果一个目标是“foo.a(bar.o)”，那么，“$%”就是“bar.o”，“$@”就是“foo.a”。如果目标不是函数库文件（Unix下是[.a]，Windows下是[.lib]），那么，其值为空。

$(@D) 和 $(@F) 分别指向 $@ 的目录名和文件名。比如，$@是 src/input.c，那么$(@D) 的值为 src ，$(@F) 的值为 input.c。
$(<D) 和 $(<F) 分别指向 $< 的目录名和文件名。

"伪目标" 当前目录中，正好有一个文件叫做clean，那么这个命令不会执行。因为Make发现clean文件已经存在，就认为没有必要重新构建了，就不会执行指定的rm命令。
.PHONY: clean
clean:
        rm *.o temp

如果Make命令运行时没有指定目标，默认会执行Makefile文件的第一个目标。

@echo $$HOME
有时，变量的值可能指向另一个变量。
VARIABLE = value　# 在执行时扩展，允许递归扩展。全局决定，都一样
VARIABLE := value　# 在定义时扩展。递归,使用便展开　可以每次不一样的　每次用的时候都会展开
VARIABLE ?= value　# 只有在该变量为空时才设置值。
VARIABLE += value　# 将值追加到变量的尾端。

%.o: %.c
等同于下面的写法。

f1.o: f1.c
f2.o: f2.c
使用匹配符%，可以将大量同类型的文件，只用一条规则就完成构建。

注释 `#`
# Makefile

##### 判断和循环

Makefile使用 Bash 语法，完成判断和循环。

```
ifeq ($(CC),gcc)
  libs=$(libs_for_gcc)
else
  libs=$(normal_libs)
endif

上面代码判断当前编译器是否 gcc ，然后指定不同的库文件。

LIST = one two three
all:
    for i in $(LIST); do \
        echo $$i; \
    done

 # 等同于

all:
    for i in one two three; do \
        echo $i; \
    done

上面代码的运行结果。

one
two
three

```


### 命令
表示如何更新目标文件，`由一行或多行的Shell命令`组成
每行命令之前必须有一个tab键。如果想用其他键，可以用内置变量.RECIPEPREFIX声明。
.RECIPEPREFIX = >
all:
> echo Hello, world

每行命令在一个单独的shell中执行。这些Shell之间没有继承关系。

var-lost:
    export foo=bar
    echo "foo=[$$foo]"
上面代码执行后（make var-lost），取不到foo的值。因为两行命令在两个不同的进程执行。一个解决办法是将两行命令写在一行，中间用分号分隔。
var-kept:
    export foo=bar; echo "foo=[$$foo]"
另一个解决办法是在换行符前加反斜杠转义。
var-kept:
    export foo=bar; \
    echo "foo=[$$foo]"
最后一个方法是加上.ONESHELL:命令。
.ONESHELL:
var-kept:
    export foo=bar; 
    echo "foo=[$$foo]"
"*"
"?"
"?" 通常在依赖文件列表中使用，匹配所有有更新的目标。

$? 表示当前依赖列表中已经更新的依赖文件

通配符的转义
当我们需要输入真实的字符 * 时，为了避免这些特殊符号被识别为通配符，需要对这些字符进行转义，比如：要操作一个真实的文件名为 *.c 时,不能直接这样输入：
obj = *.c

在当前目录下存在.c 文件时，将导致obj被赋值为所有后缀为.c的文件列表，应该使用反斜杠"\"对特殊符号进行转义。应该是这样的：
obj = \*.c

F
函数wildcard来实现上面的问题。
OBJ = ${wildcard *.o}

OBJ的赋值指定使用通配符的扩展方式，这样即使是没有匹配到任何合适的文件，${OBJ}的内容为空，而并非是错误的"*.o"。
