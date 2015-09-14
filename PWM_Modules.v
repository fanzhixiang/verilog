`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Minnesota
/*source: http://mxp.physics.umn.edu/resources/Verilog/Verilog.htm*/
// Engineer:  Kurt Wick
//
// Create Date:    12:34:32 12/02/2008
// Design Name:
// Module Name:    PWM_Modules
// Project Name:
// Target Devices:  Digilent BASYS Board with Spartan 3E FPGA (though this code is not
//                      device specific.)
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Copyright Regents University of Minnesota March  18, 2009
//    KW 12/2/08
//////////////////////////////////////////////////////////////////////////////////
//Simple PWM Switching Module
module SimplePWM(clk_in, x_in, PWM_out);
            parameter MAXBITS = 8;  //maximum number of bits for input value and counter

            input clk_in;     //clock for counter
            input [MAXBITS-1:0] x_in;     //control value that defines pulse width
            output reg PWM_out = 1; //PWM signal out

            reg [MAXBITS-1:0] counter = 0;

            always@ (posedge clk_in )begin
                  if ( counter < x_in )
                        PWM_out <= 1;
                  else
                        PWM_out <= 0;
                  counter <= counter+1;
                  end
endmodule


//Sigma Delta PWM unsigned version
module SigmaDeltaPWM(clk_in, x_in, PWM_out);
            parameter MAXBITS = 8;  //maximum number of bits for input value

            input clk_in;     //clock for counter
            input [MAXBITS-1:0] x_in;     //control value that defines pulse width
            output reg PWM_out = 1; //PWM signal out

            reg  [MAXBITS:0] Sigma = 0;   //summer

            always@ (posedge clk_in) begin  //see 8 bit version for non blocking version
                  Sigma = Sigma + x_in; //pwm_value;
                  PWM_out = Sigma[MAXBITS];
                  Sigma[MAXBITS] = 0;     //Delta: if larger or equal to 256 it subtracts it
            end

endmodule
