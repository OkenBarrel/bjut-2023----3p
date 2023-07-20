library verilog;
use verilog.vl_types.all;
entity timer is
    port(
        clk_i           : in     vl_logic;
        rst_i           : in     vl_logic;
        add_i           : in     vl_logic_vector(3 downto 2);
        dat_i           : in     vl_logic_vector(31 downto 0);
        we_i            : in     vl_logic;
        dat_o           : out    vl_logic_vector(31 downto 0);
        IQR             : out    vl_logic
    );
end timer;
