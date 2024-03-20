add_force {/systolic_top/clk} -radix hex {1 0ns} {0 50000ps} -repeat_every 100000ps
add_force {/systolic_top/rst} -radix hex {1 0ns}
run 100 ns
run 100 ns
run 50 ns
add_force {/systolic_top/rst} -radix hex {0 0ns}
add_force {/systolic_top/start} -radix hex {1 0ns}
add_force {/systolic_top/a} -radix bin {10 0ns}
add_force {/systolic_top/b} -radix bin {01 0ns}
add_force {/systolic_top/f} -radix bin {111 0ns}
run 1us
