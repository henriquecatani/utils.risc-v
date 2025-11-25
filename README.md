# utils.risc-v
Programas básicos em assembly RISC-V

REGISTERS
reg     name    desc            saver
x0      zero    zero            -
x1      ra      return address  caller
x2      sp      stack pointer   callee
x3      gp      global pointer  -
x4      tp      thread pointer  -
x5      t0      temp link reg   caller
x6-7    t1-2    temporaries     caller
x8      s0/fp   frame pointer   callee
x9      s1      saved register  callee
x10-11  a0-1    args/return val caller
x12-17  a2-7    function args   caller
x18-27  s2-11   saved registers callee
x28-31  t3-6    temporaries     caller
