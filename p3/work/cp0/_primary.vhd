library verilog;
use verilog.vl_types.all;
entity cp0 is
    port(
        pc              : in     vl_logic_vector(31 downto 2);
        din             : in     vl_logic_vector(31 downto 0);
        HWint           : in     vl_logic_vector(7 downto 2);
        sel             : in     vl_logic_vector(3 downto 0);
        cp0WR           : in     vl_logic;
        epcWR           : in     vl_logic;
        exlset          : in     vl_logic;
        exlclr          : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        IntReq          : out    vl_logic;
        epc             : out    vl_logic_vector(31 downto 2);
        dout            : out    vl_logic_vector(31 downto 0)
    );
end cp0;
