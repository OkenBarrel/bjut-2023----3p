library verilog;
use verilog.vl_types.all;
entity GPR is
    port(
        GPRWr           : in     vl_logic;
        clk             : in     vl_logic;
        rr1             : in     vl_logic_vector(4 downto 0);
        rr2             : in     vl_logic_vector(4 downto 0);
        wr              : in     vl_logic_vector(4 downto 0);
        wd              : in     vl_logic_vector(31 downto 0);
        readData1       : out    vl_logic_vector(31 downto 0);
        readData2       : out    vl_logic_vector(31 downto 0);
        alu_overflow    : in     vl_logic;
        slt_flag        : in     vl_logic
    );
end GPR;
