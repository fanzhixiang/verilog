`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*source: http://mxp.physics.umn.edu/resources/Verilog/Verilog.htm*/
// Company: University of Minnesota
// Engineer: Kurt Wick
//
// Create Date:    14:06:21 07/22/2008
// Design Name:
// Module Name:    FlashMemModules3
// Project Name:
// Target Devices: Digilent Inc PmodSF wit St Microelectronics M25P16, 16Mbit Serial Flash ROM
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Copyright Regents University of Minnesota March  18, 2009
//
//////////////////////////////////////////////////////////////////////////////////
module Flash_Send8BitInstr(clk_in, enable, instr, NCS, D, clk_out, busy);
    input clk_in;
    input enable;
       input [7:0] instr;
    output NCS;
    output D;
    output clk_out;
    output busy;

      reg [3:0] bcounter = 7;
      reg Dint = 1'bx;
      reg NCSint = 1;



      //enable latch
      reg enable_latch_set = 0;
      reg enable_latch_reset = 0;
      always@(posedge enable or posedge enable_latch_reset)
            if( enable_latch_reset)
                  enable_latch_set = 0;
            else
                  enable_latch_set = 1;


   parameter ST_IDLE = 2'b00;
   parameter ST_INIT = 2'b01;
   parameter ST_SEND = 2'b10;
   parameter ST_DONE = 2'b11;

   (* FSM_ENCODING="SEQUENTIAL", SAFE_IMPLEMENTATION="NO" *)
      reg [1:0] state = ST_IDLE;

   always@(posedge clk_in)

         (* FULL_CASE, PARALLEL_CASE *) case (state)
            ST_IDLE : begin
               if (enable_latch_set) begin
                  state <= ST_SEND;
                                    end
               else begin
                  state <= ST_IDLE;
                                    end
                        NCSint <= 1'b1;
            bcounter <= 7;
                        end


                        ST_SEND : begin
               if (bcounter)
                  state <= ST_SEND;
               else
                  state <= ST_DONE;

                              NCSint <= 1'b0;
                              Dint <= instr[bcounter];
                              bcounter <= bcounter -1;
                              enable_latch_reset <= 1'b1; //reset the enable_latch; avoid retriggering
            end

                        ST_DONE : begin
               state <= ST_IDLE;
               NCSint <= 1'b1;
                              enable_latch_reset <= 1'b0; //reset the enable_latch; allow retriggering
            end
         endcase

            assign clk_out = ~NCSint? ~clk_in : 1'bz;
            assign D = ~NCSint? Dint : 1'bz;
            assign NCS =  NCSint;
            assign busy =~NCSint | enable_latch_set;
endmodule



module Inst_BulkErase(clk_in, enable, NCS, D, clk_out, busy);
       input clk_in;
    input enable;
    output NCS;
    output D;
    output clk_out;
    output busy;

      parameter INST_BULK_ERASE = 8'hC7;
      //reg [7:0] instr;

      Flash_Send8BitInstr SendInstr_BE(clk_in, enable, INST_BULK_ERASE, NCS, D, clk_out, busy);
endmodule


module Inst_WriteEnable(clk_in, enable, NCS, D, clk_out, busy);
       input clk_in;
    input enable;

    output NCS;
    output D;
    output clk_out;
    output busy;

      parameter INST_WREN = 8'h06;
      //reg [7:0] instr;

      Flash_Send8BitInstr SendInstr_WREN(clk_in, enable, INST_WREN, NCS, D, clk_out, busy);
endmodule


module Inst_WriteDisable(clk_in, enable, NCS, D, clk_out, busy);
       input clk_in;
    input enable;
    output NCS;
    output D;
    output clk_out;
    output busy;

      //reg [7:0] instr;
      parameter INST_WRDI = 8'h04;

      Flash_Send8BitInstr SendInstr_WRDI(clk_in, enable, INST_WRDI, NCS, D, clk_out, busy);
endmodule



/*  INSTRUCTION AND READ (BACK MODULES) *************************/
// read identification: returns 20 bytes of data in datain
            //first byte: manufacturer's OD
            //second and third byte: Device ID (mem type and length)
            //Remaining 17 Bytes Unique ID set by manufacturer

module Inst_RDID(clk_in, enable, Qin, NCS, D, clk_out, busy, Qout, datain);
    input clk_in;
    input enable;
       input Qin;
    output NCS;
    output D;
    output clk_out;
    output busy;
       output Qout; //for debug only
       output datain; //(identification) data from the chip

      parameter MAXBYTES = 20; //total bytes read back:
      parameter INST_RDID = 8'h9f;
      parameter BITS_INST = 8;  //bits in the instruction
      parameter BITS_DATA = 8*MAXBYTES; //maximum bytes to be written per page 256

      reg [BITS_INST-1:0] instr; //
      reg [3:0] sendcounter = BITS_INST-1;

      reg [BITS_DATA-1:0] datain;
      reg [7:0] readcounter = BITS_DATA;

      reg Dint = 1'bx;
      reg NCSint =1;


      //enable latch
      reg enable_latch_set = 0;
      reg enable_latch_reset = 0;
      always@(posedge enable or posedge enable_latch_reset)
            if( enable_latch_reset)
                  enable_latch_set = 0;
            else
                  enable_latch_set = 1;

   parameter ST_IDLE = 2'b00;
   parameter ST_READ = 2'b01;
   parameter ST_SEND = 2'b10;
   parameter ST_DONE = 2'b11;

      reg clk_in2 =0;  //clock divider: required since the FPGA does not handle dual edge trigger
      always @(posedge clk_in)      //so we use a divide by two clock to trigger on the fast clock
            clk_in2 <= ~clk_in2;          //and then check if divide by two is low or hi.

      reg [1:0] state = ST_IDLE;
   always@( posedge clk_in)

         (* FULL_CASE, PARALLEL_CASE *) case (state)
            ST_IDLE : begin
               if (enable_latch_set  & clk_in2) begin
                  state <= ST_SEND;
                                    end
               else begin
                  state <= ST_IDLE;
                                    end
                        NCSint <= 1'b1;
            sendcounter <= BITS_INST-1;
                        readcounter <= BITS_DATA;
                        instr <= INST_RDID;
                        end

                        ST_SEND : begin
               if( clk_in2) //wants pos clock edge only
                                    state <= ST_SEND;
                              else if (sendcounter) begin
                  state <= ST_SEND;
                                    Dint <= instr[sendcounter];
                                    sendcounter <= sendcounter -1;
                                    end
               else begin
                  state <= ST_READ;
                                    Dint <= instr[sendcounter];
                                    sendcounter <= sendcounter -1;
                                    end

                              NCSint <= 1'b0;
                              enable_latch_reset <= 1'b1; //reset the enable_latch; avoid retriggering
            end


                        ST_READ : begin
                           if( ~clk_in2) //wants neg edge only
                                    state <= ST_READ;
                              else if (readcounter) begin
                  state <= ST_READ;
                                    datain <= {datain[BITS_DATA-2:0], Qin};
                                    readcounter <= readcounter -1;
                                    end
               else begin
                  state <= ST_DONE;
                                    datain <= {datain[BITS_DATA-2:0], Qin};
                                    sendcounter <= sendcounter -1;
                                    end

                              NCSint <= 1'b0;
            end


                        ST_DONE : begin
                              if( ~clk_in2)
                                    state <= ST_DONE;
                              else begin
                                    state <= ST_IDLE;
                                    NCSint <= 1'b1;
                                    enable_latch_reset <= 1'b0; //reset the enable_latch; allow retriggering
                              end
            end
         endcase


            assign clk_out = ~NCSint? ~clk_in2 : 1'bz;
            assign D = ~NCSint? Dint : 1'bz;
            assign NCS =  NCSint;
            assign busy =~NCSint | enable_latch_set;
            assign Qout = ~NCSint ? Qin : 1'bz;
endmodule




// read status register: returns 1 byte of data in datain
            //first byte: manufacturer's OD
            /* bit 7: Status Reg Write Protect
            bits 2 to 4: BP0 to BP2 (Block protect bits)
            bit 1: Write Enable Latch
            bit 0: Write in Progress bit */

module Inst_RDSR(clk_in, enable, Qin, NCS, D, clk_out, busy, Qout, datain);
    input clk_in;
    input enable;
       input Qin;
    output NCS;
    output D;
    output clk_out;
    output busy;
       output Qout; //for debug only
       output datain; //(identification) data from the chip

      parameter MAXBYTES = 1; //total bytes read back:
      parameter INST_RDSR = 8'h05;
      parameter BITS_INST = 8;  //bits in the instruction
      parameter BITS_DATA = 8*MAXBYTES; //maximum bytes to be written per page 256

      reg [BITS_INST-1:0] instr; //
      reg [3:0] sendcounter = BITS_INST-1;

      reg [BITS_DATA-1:0] datain;
      reg [7:0] readcounter = BITS_DATA;

      reg Dint = 1'bx;
      reg NCSint =1;


      //enable latch
      reg enable_latch_set = 0;
      reg enable_latch_reset = 0;
      always@(posedge enable or posedge enable_latch_reset)
            if( enable_latch_reset)
                  enable_latch_set = 0;
            else
                  enable_latch_set = 1;


   parameter ST_IDLE = 2'b00;
   parameter ST_READ = 2'b01;
   parameter ST_SEND = 2'b10;
   parameter ST_DONE = 2'b11;

      reg clk_in2 =0;  //clock divider: required since the FPGA does not handle dual edge trigger
      always @(posedge clk_in)      //so we use a divide by two clock to trigger on the fast clock
            clk_in2 <= ~clk_in2;          //and then check if divide by two is low or hi.

      reg [1:0] state = ST_IDLE;
   always@( posedge clk_in)

         (* FULL_CASE, PARALLEL_CASE *) case (state)
            ST_IDLE : begin
               if (enable_latch_set & clk_in2) begin
                  state <= ST_SEND;
                                    end
               else begin
                  state <= ST_IDLE;
                                    end
                        NCSint <= 1'b1;
            sendcounter <= BITS_INST-1;
                        readcounter <= BITS_DATA;
                        instr <= INST_RDSR;
                        end

                        ST_SEND : begin
               if( clk_in2) //wants pos clock edge only
                                    state <= ST_SEND;
                              else if (sendcounter) begin
                  state <= ST_SEND;
                                    Dint <= instr[sendcounter];
                                    sendcounter <= sendcounter -1;
                                    end
               else begin
                  state <= ST_READ;
                                    Dint <= instr[sendcounter];
                                    sendcounter <= sendcounter -1;
                                    end

                              NCSint <= 1'b0;
                              enable_latch_reset <= 1'b1; //reset the enable_latch; avoid retriggering
            end


                        ST_READ : begin
                           if( ~clk_in2) //wants neg edge only
                                    state <= ST_READ;
                              else if (readcounter) begin
                  state <= ST_READ;
                                    datain <= {datain[BITS_DATA-2:0], Qin};
                                    readcounter <= readcounter -1;
                                    end
               else begin
                  state <= ST_DONE;
                                    datain <= {datain[BITS_DATA-2:0], Qin};
                                    sendcounter <= sendcounter -1;
                                    end

                              NCSint <= 1'b0;
            end


                        ST_DONE : begin
                              if( ~clk_in2)
                                    state <= ST_DONE;
                              else begin
                                    state <= ST_IDLE;
                                    NCSint <= 1'b1;
                                    enable_latch_reset <= 1'b0; //reset the enable_latch; allow retriggering
                              end
            end
         endcase


            assign clk_out = ~NCSint? ~clk_in2 : 1'bz;
            assign D = ~NCSint? Dint : 1'bz;
            assign NCS =  NCSint;
            assign busy =~NCSint | enable_latch_set;
            assign Qout = ~NCSint ? Qin : 1'bz;
endmodule

/* Warning changing MAXBYTES to 256 will make compiling very slow!!!!!!!!!!
//page program instruction
//programs up to 256 bytes at a time
module Inst_PP(clk_in, enable, address, datain, numbytes, NCS, D, clk_out, busy);
    input clk_in;
    input enable;
       input [23:0] address;
       input [7:0] datain;  //change back to 2047 AFTER TEST!
       input [7:0] numbytes;  //num of bytes to be actually written
    output NCS;
    output D;
    output clk_out;
    output busy;

      parameter MAXBYTES = 256; //CHANGE HERE TO 256!!!maximum bytes to be written per page 256
      parameter INST_PP = 8'h02;
      parameter BITS_INST = 8;
      parameter BITS_ADDR = 24;
      parameter BITS_DATA = 8*MAXBYTES; //maximum bytes to be written per page 256

      reg [BITS_INST+BITS_ADDR+BITS_DATA-1:0] instr; // = INST_PP;
      reg [11:0] bcounter = BITS_INST+BITS_ADDR+BITS_DATA-1;
      //reg [BITS_DATA-1:0] data = 32'hA5A5_A5A5;  //put bits here

      reg Dint = 1'bx;
      reg NCSint = 1;


      //enable latch
      reg enable_latch_set = 0;
      reg enable_latch_reset = 0;
      always@(posedge enable or posedge enable_latch_reset)
            if( enable_latch_reset)
                  enable_latch_set = 0;
            else
                  enable_latch_set = 1;



   parameter ST_IDLE = 2'b00;
   parameter ST_INIT = 2'b01;
   parameter ST_SEND = 2'b10;
   parameter ST_DONE = 2'b11;

   (* FSM_ENCODING="SEQUENTIAL", SAFE_IMPLEMENTATION="NO" *)
      reg [1:0] state = ST_IDLE;

   always@(posedge clk_in)

         (* FULL_CASE, PARALLEL_CASE *) case (state)
            ST_IDLE : begin
               if (enable_latch_set) begin
                  state <= ST_SEND;
                                    end
               else begin
                  state <= ST_IDLE;
                                    end
                        NCSint <= 1'b1;
            bcounter <= BITS_INST+BITS_ADDR+BITS_DATA-1;
                        instr <= {INST_PP, address, datain };
                        end


                        ST_SEND : begin
               if (bcounter)
                  state <= ST_SEND;
               else
                  state <= ST_DONE;

                              NCSint <= 1'b0;
                              Dint <= instr[bcounter];
                              bcounter <= bcounter -1;
                              enable_latch_reset <= 1'b1; //reset the enable_latch; avoid retriggering
            end

                        ST_DONE : begin
               state <= ST_IDLE;
               NCSint <= 1'b1;
                              enable_latch_reset <= 1'b0; //reset the enable_latch; allow retriggering
            end
         endcase

            assign clk_out = ~NCSint? ~clk_in : 1'bz;
            assign D = ~NCSint? Dint : 1'bz;
            assign NCS =  NCSint;
            assign busy =~NCSint | enable_latch_set;
endmodule
*/


//Read Data Back from flash memory  TESTED WORKS 7-24-08 KW
module Inst_READ_OneByte(clk_in, enable, address, Qin, NCS, D, clk_out, busy, Qout, datain);
    input clk_in;
    input enable;
       input [23:0] address;
       input Qin;
    output NCS;
    output D;
    output clk_out;
    output busy;
       output datain;
       output Qout;

      parameter MAXBYTES = 1; //maximum bytes read can be infinite as entire memory can be read
      parameter INST_READ = 8'h03;
      parameter BITS_INST = 8;
      parameter BITS_ADDR = 24;
      parameter BITS_DATA = 8*MAXBYTES; //maximum bytes to be written per page 256

      reg [BITS_INST+BITS_ADDR-1:0] instr; //
      reg [5:0] bcounter = BITS_INST+BITS_ADDR-1;

      reg [BITS_DATA-1:0] datain;
      reg [10:0] readcounter = BITS_DATA;

      reg Dint = 1'bx;
      reg NCSint = 1;

      reg clk_in2=0;  //clock divider
      always @(posedge clk_in)
            clk_in2 <= ~clk_in2;

      //enable latch
      reg enable_latch_set = 0;
      reg enable_latch_reset = 0;
      always@(posedge enable or posedge enable_latch_reset)
            if( enable_latch_reset)
                  enable_latch_set = 0;
            else
                  enable_latch_set = 1;


   parameter ST_IDLE = 2'b00;
   parameter ST_READ = 2'b01;
   parameter ST_SEND = 2'b10;
   parameter ST_DONE = 2'b11;

   (* FSM_ENCODING="SEQUENTIAL", SAFE_IMPLEMENTATION="NO" *)
      reg [1:0] state = ST_IDLE;

   always@( posedge clk_in)

         (* FULL_CASE, PARALLEL_CASE *) case (state)
            ST_IDLE : begin
               if (enable_latch_set & clk_in2) begin
                  state <= ST_SEND;
                                    end
               else begin
                  state <= ST_IDLE;
                                    end
                        NCSint <= 1'b1;
            bcounter <= BITS_INST+BITS_ADDR-1;
                        readcounter <= BITS_DATA;
                        instr <= {INST_READ, address  };
                        end

                        ST_SEND : begin
               if( clk_in2) //wants pos clock edge only
                                    state <= ST_SEND;
                              else if (bcounter) begin
                  state <= ST_SEND;
                                    Dint <= instr[bcounter];
                                    bcounter <= bcounter -1;
                                    end
               else begin
                  state <= ST_READ;
                                    Dint <= instr[bcounter];
                                    bcounter <= bcounter -1;
                                    end

                              NCSint <= 1'b0;
                              enable_latch_reset <= 1'b1; //reset the enable_latch; avoid retriggering
            end


                        ST_READ : begin
                           if( ~clk_in2) //wants neg edge only
                                    state <= ST_READ;
                              else if (readcounter) begin
                  state <= ST_READ;
                                    //DataRead <= {DataRead[MAXBITS-2:0], Qin };
                                    datain <= {datain[BITS_DATA-2:0], Qin};
                                    readcounter <= readcounter -1;
                                    end
               else begin
                  state <= ST_DONE;
                                    //DataRead <= {DataRead[MAXBITS-2:0], Qin };
                                    datain <= {datain[BITS_DATA-2:0], Qin};
                                    readcounter <= readcounter -1;
                                    end

                              NCSint <= 1'b0;
            end


                        ST_DONE : begin
                              if( ~clk_in2)
                                    state <= ST_DONE;
                              else begin
                                    state <= ST_IDLE;
                                    NCSint <= 1'b1;
                                    enable_latch_reset <= 1'b0; //reset the enable_latch; allow retriggering
                              end

            end

         endcase

            assign clk_out = ~NCSint? ~clk_in2 : 1'bz;
            assign D = ~NCSint? Dint : 1'bz;
            assign NCS =  NCSint;
            assign busy =~NCSint | enable_latch_set;
            assign Qout = ~NCSint ? Qin : 1'bz;

endmodule


//Read Data Back from flash memory
// Tested works up to 256 bytes
//currently set to 128 though!!!!!!!!!!!!!!
module Inst_READ_256Bytes(clk_in, enable, address, Qin, NCS, D, clk_out, busy, Qout, datain);
    input clk_in;
    input enable;
       input [23:0] address;
       input Qin;
    output NCS;
    output D;
    output clk_out;
    output busy;
       output datain;
       output Qout;

      parameter MAXBYTES = 128; //256; //maximum bytes read can be infinite as entire memory can be read
      parameter INST_READ = 8'h03;
      parameter BITS_INST = 8;
      parameter BITS_ADDR = 24;
      parameter BITS_DATA = 8*MAXBYTES; //maximum bytes to be written per page 256

      reg [BITS_INST+BITS_ADDR-1:0] instr; //
      reg [5:0] bcounter = BITS_INST+BITS_ADDR-1;

      reg [BITS_DATA-1:0] datain;
      reg [12:0] readcounter = BITS_DATA; //11 bits should be enough

      reg Dint = 1'bx;
      reg NCSint = 1;

      reg clk_in2=0;  //clock divider
      always @(posedge clk_in)
            clk_in2 <= ~clk_in2;

      //enable latch
      reg enable_latch_set = 0;
      reg enable_latch_reset = 0;
      always@(posedge enable or posedge enable_latch_reset)
            if( enable_latch_reset)
                  enable_latch_set = 0;
            else
                  enable_latch_set = 1;



   parameter ST_IDLE = 2'b00;
   parameter ST_READ = 2'b01;
   parameter ST_SEND = 2'b10;
   parameter ST_DONE = 2'b11;

   (* FSM_ENCODING="SEQUENTIAL", SAFE_IMPLEMENTATION="NO" *)
      reg [1:0] state = ST_IDLE;

   always@( posedge clk_in)

         (* FULL_CASE, PARALLEL_CASE *) case (state)
            ST_IDLE : begin
               if (enable_latch_set  & clk_in2) begin
                  state <= ST_SEND;
                                    end
               else begin
                  state <= ST_IDLE;
                                    end
                        NCSint <= 1'b1;
            bcounter <= BITS_INST+BITS_ADDR-1;
                        readcounter <= BITS_DATA;
                        instr <= {INST_READ, address  };
                        end

                        ST_SEND : begin
               if( clk_in2) //wants pos clock edge only
                                    state <= ST_SEND;
                              else if (bcounter) begin
                  state <= ST_SEND;
                                    Dint <= instr[bcounter];
                                    bcounter <= bcounter -1;
                                    end
               else begin
                  state <= ST_READ;
                                    Dint <= instr[bcounter];
                                    bcounter <= bcounter -1;
                                    end

                              NCSint <= 1'b0;
                              enable_latch_reset <= 1'b1; //reset the enable_latch; avoid retriggering
            end


                        ST_READ : begin
                           if( ~clk_in2) //wants neg edge only
                                    state <= ST_READ;
                              else if (readcounter) begin
                  state <= ST_READ;
                                    //DataRead <= {DataRead[MAXBITS-2:0], Qin };
                                    datain <= {datain[BITS_DATA-2:0], Qin};
                                    readcounter <= readcounter -1;
                                    end
               else begin
                  state <= ST_DONE;
                                    //DataRead <= {DataRead[MAXBITS-2:0], Qin };
                                    datain <= {datain[BITS_DATA-2:0], Qin};
                                    readcounter <= readcounter -1;
                                    end

                              NCSint <= 1'b0;
            end


                        ST_DONE : begin
                              if( ~clk_in2)
                                    state <= ST_DONE;
                              else begin
                                    state <= ST_IDLE;
                                    NCSint <= 1'b1;
                                    enable_latch_reset <= 1'b0; //reset the enable_latch; allow retriggering
                              end
            end

         endcase

            assign clk_out = ~NCSint? ~clk_in2 : 1'bz;
            assign D = ~NCSint? Dint : 1'bz;
            assign NCS =  NCSint;
            assign busy =~NCSint | enable_latch_set;
            assign Qout = ~NCSint ? Qin : 1'bz;

endmodule


//programs one byte at a time using PP instruction
module Inst_WriteOneByte(clk_in, enable, address, datain, NCS, D, clk_out, busy);
    input clk_in;
    input enable;
       input [23:0] address;
       input [7:0] datain;  //change back to 2047 AFTER TEST!
    output NCS;
    output D;
    output clk_out;
    output busy;

      parameter MAXBYTES = 1; //256; //maximum bytes to be written per page 256
      parameter INST_PP = 8'h02;
      parameter BITS_INST = 8;
      parameter BITS_ADDR = 24;
      parameter BITS_DATA = 8*MAXBYTES; //maximum bytes to be written per page 256

      reg [BITS_INST+BITS_ADDR+BITS_DATA-1:0] instr; // = INST_PP;
      reg [6:0] bcounter = BITS_INST+BITS_ADDR+BITS_DATA-1;
      //reg [BITS_DATA-1:0] data = 32'hA5A5_A5A5;  //put bits here

      reg Dint = 1'bx;
      reg NCSint = 1;


      //enable latch
      reg enable_latch_set = 0;
      reg enable_latch_reset = 0;
      always@(posedge enable or posedge enable_latch_reset)
            if( enable_latch_reset)
                  enable_latch_set = 0;
            else
                  enable_latch_set = 1;



   parameter ST_IDLE = 2'b00;
   parameter ST_INIT = 2'b01;
   parameter ST_SEND = 2'b10;
   parameter ST_DONE = 2'b11;

   (* FSM_ENCODING="SEQUENTIAL", SAFE_IMPLEMENTATION="NO" *)
      reg [1:0] state = ST_IDLE;

   always@(posedge clk_in)

         (* FULL_CASE, PARALLEL_CASE *) case (state)
            ST_IDLE : begin
               if (enable_latch_set) begin
                  state <= ST_SEND;
                                    end
               else begin
                  state <= ST_IDLE;
                                    end
                        NCSint <= 1'b1;
            bcounter <= BITS_INST+BITS_ADDR+BITS_DATA-1;
                        instr <= {INST_PP, address, datain };
                        end


                        ST_SEND : begin
               if (bcounter)
                  state <= ST_SEND;
               else
                  state <= ST_DONE;

                              NCSint <= 1'b0;
                              Dint <= instr[bcounter];
                              bcounter <= bcounter -1;
                              enable_latch_reset <= 1'b1; //reset the enable_latch; avoid retriggering
            end

                        ST_DONE : begin
               state <= ST_IDLE;
               NCSint <= 1'b1;
                              enable_latch_reset <= 1'b0; //reset the enable_latch; allow retriggering
            end
         endcase

            assign clk_out = ~NCSint? ~clk_in : 1'bz;
            assign D = ~NCSint? Dint : 1'bz;
            assign NCS =  NCSint;
            assign busy =~NCSint | enable_latch_set;
endmodule



//Read 2 Bytes of Data Back from flash memory  TESTED WORKS 9-12-08 KW
//formerly known as:
//module Inst_READ_TwoBytes(clk_in, enable, address, Q, NCS, D, clk_out, busy, data);
module ReadTwoBytes(clk_in, enable, address, Q, NCS, D, clk_out, busy, data);
      parameter NEWMAXBYTES = 2;

    input clk_in;
    input enable;
       input [23:0] address;
       input Q;
    output NCS;
    output D;
    output clk_out;
    output busy;
       output [8*NEWMAXBYTES-1:0] data;


defparam
      XReadOneFlashByte.MAXBYTES = NEWMAXBYTES;

ReadOneByte XReadOneFlashByte(clk_in, enable, address, Q, NCS, D, clk_out, busy, data);
endmodule



//Read Data Back from flash memory  TESTED WORKS 7-24-08 KW
// updated to buffer output (data_in) till it is ready and then assign it to "data" kw 9-12-08
//formerly known as:
//module Inst_READ_One_Buffered_Byte(clk_in, enable, address, Q, NCS, D, clk_out, busy, data);
module ReadOneByte(clk_in, enable, address, Q, NCS, D, clk_out, busy, data);
    input clk_in;  //sys clock that times read / write instructions
    input enable;  //trigger - on positive edge enabled
       input [23:0] address; //starting read address
       input Q;         //Q line to Flash Memory - reads data from memory
    output NCS;   //Not Chip Select line for Flash Memory
    output D;           //D line to Flash Memory - sends data to memory
    output clk_out;     //clk line to Memory
    output busy;  //positive while reading; neg edge when done reading one byte
       output data;     //data read from memory


      parameter MAXBYTES = 1; //maximum bytes read can be infinite as entire memory can be read
      parameter INST_READ = 8'h03;
      parameter BITS_INST = 8;
      parameter BITS_ADDR = 24;
      parameter BITS_DATA = 8*MAXBYTES; //maximum bytes to be written per page 256

      reg [BITS_INST+BITS_ADDR-1:0] instr; //
      reg [5:0] bcounter = BITS_INST+BITS_ADDR-1;

      reg [BITS_DATA-1:0] datain; //temp buffer to assemble data
      reg [BITS_DATA-1:0] data; //final buffer once byte is assembled
      reg [10:0] readcounter = BITS_DATA;

      reg Dint = 1'bx;
      reg NCSint = 1;

      reg clk_in2=0;  //clock divider
      always @(posedge clk_in)
            clk_in2 <= ~clk_in2;

      //enable latch
      reg enable_latch_set = 0;
      reg enable_latch_reset = 0;
      always@(posedge enable or posedge enable_latch_reset)
            if( enable_latch_reset)
                  enable_latch_set = 0;
            else
                  enable_latch_set = 1;


   parameter ST_IDLE = 2'b00;
   parameter ST_READ = 2'b01;
   parameter ST_SEND = 2'b10;
   parameter ST_DONE = 2'b11;

   (* FSM_ENCODING="SEQUENTIAL", SAFE_IMPLEMENTATION="NO" *)
      reg [1:0] state = ST_IDLE;

   always@( posedge clk_in)

         (* FULL_CASE, PARALLEL_CASE *) case (state)
            ST_IDLE : begin
               if (enable_latch_set & clk_in2) begin
                  state <= ST_SEND;
                                    end
               else begin
                  state <= ST_IDLE;
                                    end
                        NCSint <= 1'b1;
            bcounter <= BITS_INST+BITS_ADDR-1;
                        readcounter <= BITS_DATA;
                        instr <= {INST_READ, address  };
                        end

                        ST_SEND : begin
               if( clk_in2) //wants pos clock edge only
                                    state <= ST_SEND;
                              else if (bcounter) begin
                  state <= ST_SEND;
                                    Dint <= instr[bcounter];
                                    bcounter <= bcounter -1;
                                    end
               else begin
                  state <= ST_READ;
                                    Dint <= instr[bcounter];
                                    bcounter <= bcounter -1;
                                    end

                              NCSint <= 1'b0;
                              enable_latch_reset <= 1'b1; //reset the enable_latch; avoid retriggering
            end


                        ST_READ : begin
                           if( ~clk_in2) //wants neg edge only
                                    state <= ST_READ;
                              else if (readcounter) begin
                  state <= ST_READ;
                                    //DataRead <= {DataRead[MAXBITS-2:0], Q };
                                    datain <= {datain[BITS_DATA-2:0], Q};
                                    readcounter <= readcounter -1;
                                    end
               else begin
                  state <= ST_DONE;
                                    //DataRead <= {DataRead[MAXBITS-2:0], Q };
                                    datain <= {datain[BITS_DATA-2:0], Q};
                                    readcounter <= readcounter -1;
                                    end

                              NCSint <= 1'b0;
            end


                        ST_DONE : begin
                              if( ~clk_in2)
                                    state <= ST_DONE;
                              else begin
                                    state <= ST_IDLE;
                                    NCSint <= 1'b1;
                                    enable_latch_reset <= 1'b0; //reset the enable_latch; allow retriggering
                                    data <= datain;
                              end

            end

         endcase

            assign clk_out = ~NCSint? ~clk_in2 : 1'bz;
            assign D = ~NCSint? Dint : 1'bz;
            assign NCS =  NCSint;
            assign busy =~NCSint | enable_latch_set;
            assign Qout = ~NCSint ? Q : 1'bz;

endmodule
