library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        in1             : in     vl_logic_vector(31 downto 0);
        in2             : in     vl_logic_vector(31 downto 0);
        sel             : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0);
        zero            : out    vl_logic;
        overflow_flag   : out    vl_logic;
        less_than       : out    vl_logic
    );
end alu;
