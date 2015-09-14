library verilog;
use verilog.vl_types.all;
entity test_fsm is
    generic(
        A0              : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi0);
        A1              : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi1);
        A2              : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi0);
        A3              : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi1);
        A4              : vl_logic_vector(2 downto 0) := (Hi1, Hi0, Hi0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of A0 : constant is 2;
    attribute mti_svvh_generic_type of A1 : constant is 2;
    attribute mti_svvh_generic_type of A2 : constant is 2;
    attribute mti_svvh_generic_type of A3 : constant is 2;
    attribute mti_svvh_generic_type of A4 : constant is 2;
end test_fsm;
