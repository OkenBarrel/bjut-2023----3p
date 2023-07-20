library verilog;
use verilog.vl_types.all;
entity fsm is
    generic(
        s0              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi0);
        s1              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        s2              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        s3              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi1);
        s4              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi0);
        s5              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi1);
        s6              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi0);
        s7              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1);
        s8              : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi0);
        s9              : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi1);
        s10             : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi1, Hi0);
        s11             : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        zero            : in     vl_logic;
        opcode          : in     vl_logic_vector(5 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        PCWr            : out    vl_logic;
        IRWr            : out    vl_logic;
        regDst          : out    vl_logic_vector(1 downto 0);
        ALUSrc          : out    vl_logic;
        writeData       : out    vl_logic_vector(1 downto 0);
        GPRWr           : out    vl_logic;
        DMWr            : out    vl_logic;
        nPCsel          : out    vl_logic_vector(2 downto 0);
        extsel          : out    vl_logic_vector(1 downto 0);
        ALUsel          : out    vl_logic_vector(1 downto 0);
        overflow        : out    vl_logic;
        slt_ctrl        : out    vl_logic;
        dmsel           : out    vl_logic_vector(1 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of s0 : constant is 1;
    attribute mti_svvh_generic_type of s1 : constant is 1;
    attribute mti_svvh_generic_type of s2 : constant is 1;
    attribute mti_svvh_generic_type of s3 : constant is 1;
    attribute mti_svvh_generic_type of s4 : constant is 1;
    attribute mti_svvh_generic_type of s5 : constant is 1;
    attribute mti_svvh_generic_type of s6 : constant is 1;
    attribute mti_svvh_generic_type of s7 : constant is 1;
    attribute mti_svvh_generic_type of s8 : constant is 1;
    attribute mti_svvh_generic_type of s9 : constant is 1;
    attribute mti_svvh_generic_type of s10 : constant is 1;
    attribute mti_svvh_generic_type of s11 : constant is 1;
end fsm;
