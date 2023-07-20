library verilog;
use verilog.vl_types.all;
entity out32 is
    port(
        clk             : in     vl_logic;
        \in\            : in     vl_logic_vector(31 downto 0);
        we              : in     vl_logic;
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end out32;
