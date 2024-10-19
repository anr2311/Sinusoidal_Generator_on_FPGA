# Sinusoidal_Generator_on_FPGA

This repo contains Verilog design and testbench files for a PWM signal generation (duty cycle varies with amplitude of pre-computed sine wave) targetted for Zync Zedboard:

<img width="471" alt="image" src="https://github.com/user-attachments/assets/75dbdf30-fbdd-45c3-8dfe-8f9a249b5308">

An online sine wave generator produces a lookup table vector which when plotted (in MATLAB) provides the following sine wave cycle with 256 levels:

![image](https://github.com/user-attachments/assets/b81cf380-a82d-4f12-8983-a4d5987ac2e4)

The above pre-computed sine wave is programmed as an LUT in the source files and a PWM signal is generated whose duty cycle varies with the sine wave's amplitude:

![image](https://github.com/user-attachments/assets/a6d1b03a-19b6-4fea-bd25-371516b1c68a)

The PWM signal is generated on the JB7 pin of the FPGA:

![image](https://github.com/user-attachments/assets/b79574f3-ee28-4a1c-aebd-9093a2259309)

The design also offers the use of an Integrated Logic Analyzer (ILA) that can tap the sinusoidal and PWM signals:

![image](https://github.com/user-attachments/assets/50a1a9a3-fab2-48cf-8174-c3b5582f0ccf)
