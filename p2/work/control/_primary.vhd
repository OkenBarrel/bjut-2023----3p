library verilog;
use verilog.vl_types.all;
entity control is
    port(
        opcode          : in     vl_logic_vector(5 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        regDst          : out    vl_logic_vector(1 downto 0);
        ALUSrc          : out    vl_logic;
        writeData       : out    vl_logic_vector(1 downto 0);
        regWrite        : out    vl_logic;
        memWrite        : out    vl_logic;
        nPCsel          : out    vl_logic_vector(2 downto 0);
        extsel          : out    vl_logic_vector(1 downto 0);
        ALUsel          : out    vl_logic_vector(1 downto 0);
        overflow        : out    vl_logic;
        slt_ctrl        : out    vl_logic
    );
end control;
