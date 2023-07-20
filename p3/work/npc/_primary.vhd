library verilog;
use verilog.vl_types.all;
entity npc is
    port(
        pc              : in     vl_logic_vector(31 downto 0);
        npc_sel         : in     vl_logic_vector(2 downto 0);
        epc             : in     vl_logic_vector(31 downto 0);
        imm             : in     vl_logic_vector(25 downto 0);
        zero            : in     vl_logic;
        jr_in           : in     vl_logic_vector(31 downto 0);
        npc             : out    vl_logic_vector(31 downto 0);
        jal_save        : out    vl_logic_vector(31 downto 0)
    );
end npc;
