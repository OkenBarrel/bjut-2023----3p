library verilog;
use verilog.vl_types.all;
entity mips is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        PrDin           : in     vl_logic_vector(31 downto 0);
        HWint           : in     vl_logic_vector(7 downto 2);
        Praddr          : out    vl_logic_vector(31 downto 2);
        WEcpu           : out    vl_logic;
        PrDout          : out    vl_logic_vector(31 downto 0)
    );
end mips;
