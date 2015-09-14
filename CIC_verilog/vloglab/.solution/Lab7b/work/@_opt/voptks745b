library verilog;
use verilog.vl_types.all;
entity fsm_mealy is
    generic(
        S0              : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        S1              : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        S2              : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        S3              : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        en              : in     vl_logic;
        xin             : in     vl_logic;
        zout            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of S0 : constant is 1;
    attribute mti_svvh_generic_type of S1 : constant is 1;
    attribute mti_svvh_generic_type of S2 : constant is 1;
    attribute mti_svvh_generic_type of S3 : constant is 1;
end fsm_mealy;
