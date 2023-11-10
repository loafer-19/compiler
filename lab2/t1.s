.arch armv7-a
.syntax unified
.thumb
.thumb_func

.data
input_prompt:
    .asciz  "请输入要计算阶乘的数: "
input_num:
    .word   0
scanf_fmt:
    .asciz  "%d"
result_fmt:
    .asciz  "%d的阶乘为：%d\n"

.text
.global main

main:
    @ 保存寄存器状态
    push    {r4, lr}

    @ 输入要计算阶乘的数
    ldr     r0, =input_prompt
    bl      printf

    ldr     r0, =scanf_fmt
    ldr     r1, =input_num
    bl      scanf

    @ 初始化循环计数器和结果
    mov     r4, #1      @ 计数器（用于阶乘计算）
    mov     r5, #1      @ 结果

compute_factorial:
    @ 比较计数器和输入值
    cmp     r4, r1
    bgt     print_result

    @ 计算阶乘
    mul     r5, r5, r4  @ r5 = r5 * r4
    add     r4, r4, #1  @ 计数器加1
    b       compute_factorial

print_result:
    @ 输出结果
    ldr     r0, =result_fmt
    ldr     r1, =input_num
    ldr     r2, =r5      @ 阶乘结果
    bl      printf

    @ 恢复寄存器状态并退出
    pop     {r4, lr}

    @ 退出程序
    mov     r7, #1       @ 使用0x1退出程序
    swi     0x0

