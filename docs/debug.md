Bug: Control Unit Testbench Failed

    Issue: Waveform shows incorrect values for the output signals. ![Waveform before fix](Control_Unit_Testbench_Waveform_Fail.webp)

    Problem: With some research, I determined that icarus verilog doesn't support certain SystemVerilog features which caused an issue with taking certain bits from an array in always_comb. Additionally, the #10 delays were placed after the checks rather than between the new instruction and the checks. 

    Fix: Use older Verilog syntax instead of SystemVerilog syntax for the features that were not supported on Icarus Verilog. Additionally, changed the timing of the delays. This fixed the issue as seen below. ![Waveform after fix](Control_Unit_Testbench_Waveform_Pass.webp)

