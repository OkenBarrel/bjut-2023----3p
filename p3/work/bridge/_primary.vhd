library verilog;
use verilog.vl_types.all;
entity bridge is
    port(
        addr            : in     vl_logic_vector(31 downto 2);
        WEcpu           : in     vl_logic;
        writeData       : in     vl_logic_vector(31 downto 0);
        timer_rd        : in     vl_logic_vector(31 downto 0);
        in32_rd         : in     vl_logic_vector(31 downto 0);
        out32_rd        : in     vl_logic_vector(31 downto 0);
        readData        : out    vl_logic_vector(31 downto 0);
        dev_addr        : out    vl_logic_vector(1 downto 0);
        dev_writeData   : out    vl_logic_vector(31 downto 0);
        we              : out    vl_logic_vector(2 downto 0)
    );
end bridge;
