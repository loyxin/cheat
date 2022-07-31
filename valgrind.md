## Valgrind
Valgrind 是运行在Linux上一套基于仿真技术的程序调试和分析工具
- memcheck：检查程序中的内存问题，如泄漏、越界、非法指针等。
- callgrind：检测程序代码覆盖，以及分析程序性能。
- cachegrind：分析CPU的cache命中率、丢失率，用于进行代码优化。
- helgrind：用于检查多线程程序的竞态条件。
- massif：堆栈分析器，指示程序中使用了多少堆内存等信息。

### Memcheck
- 对未初始化内存的使用；
- 读/写释放后的内存块；
- 读/写超出malloc分配的内存块；
- 读/写不适当的栈中内存块；
- 内存泄漏，指向一块内存的指针永远丢失；
- 不正确的malloc/free或new/delete匹配；
- memcpy()相关函数中的dst和src指针重叠。

### usage

` valgrind --log-file=vargrind.log --tool=memcheck --leak-check=full ./main(运行程序)`

definitely lost：如果一个block在程序在退出后，memcheck找不到指向它的pointer，一般是由于在代码中对该block没有free造成的，要重点关注。

"indirectly lost"：间接丢失。当使用了含有指针成员的类或结构时可能会报这个错误。这类错误无需直接修复，他们总是与"definitely lost"一起出现，只要修复"definitely lost"即可。

possibly lost：在程序退出时，memcheck发现仍有 interior pointer（如果一个pointer指向一个block的中间某个位置）指向一个block，那么该block被认为是possibly lost。

still reachable：如果memcheck发现仍有start pointer指向一个block，那么该block就是still reachable。
