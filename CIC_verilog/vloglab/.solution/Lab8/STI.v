module STI(clk ,reset, load, pi_data,  pi_msb, pi_low,
           so_data, so_valid );

input       clk, reset;
input       load, pi_msb, pi_low; 
input   [15:0]  pi_data;

output      so_data, so_valid;

//==============================================================================
//==============================================================================
reg so_data, so_valid;
reg [7:0] so_data8;
reg [15:0] so_data16;


reg     msb, low; 
reg [15:0]  tmp_data, tmp_data16 ;
reg     [7:0]   tmp_data8;



integer i;

reg [4:0] pat_all;

reg [15:0] tmp_pi;

integer s;

reg     [1:0] n_state, c_state;
parameter   idle = 2'b00, process1 = 2'b01, process2 = 2'b10, dataout = 2'b11;



always@(posedge clk or posedge reset) begin
if (reset) begin
    c_state <= idle;
    i <= 0; 
end
else begin
    c_state <= n_state;
    if (c_state == dataout) begin  i <= i + 1; end
    else begin i <= 0;  end
end
end

reg valid;
reg so_valid1;
always@(posedge clk) so_valid1 <= valid;
always@(*) so_valid = so_valid1 | valid;

always@(*) begin
case (c_state)
    idle : begin
        valid = 0;
        if (load) begin
            msb = pi_msb;
            low = pi_low;
            tmp_data = pi_data;
            n_state = process1;
            end
        else begin
            msb = 1;
            low = 0;
            tmp_data = 0;
            n_state = idle;
            so_data = 0;
            end
        end
    process1 : begin
        tmp_data8 = tmp_data[7:0];
        tmp_data16 = tmp_data;
        n_state = process2;
        valid = 0;
        end
    process2 : begin
        case (pi_low)
        0 : begin
            pat_all = 7;
            if (!msb) so_data8 = tmp_data8;
            else so_data8 = rot8(tmp_data8);
            end
        1 : begin
            pat_all = 15;
            if (!msb) so_data16 = tmp_data16;
            else so_data16 = rot16(tmp_data16);
            end
        endcase
        n_state = dataout;
        valid = 0;
        end
    dataout : begin
        case (pi_low)
        0 : so_data = so_data8[i];
        1 : so_data = so_data16[i];
        endcase
        if (i == pat_all) begin n_state = idle;   valid = 0; end
        else begin n_state = dataout;  valid = 1;end
        end
endcase
end


function [7:0]rot8;
    input [7:0] di8;
    integer k;
    for (k=0; k<8; k=k+1)
    rot8[ 8-(k+1)] = di8[k];
endfunction

function [15:0]rot16;
    input [15:0] di16;
    integer k;
    for (k=0; k<16; k=k+1)
    rot16[ 16-(k+1)] = di16[k];
endfunction




endmodule




