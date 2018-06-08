library verilog;
use verilog.vl_types.all;
entity contador is
    port(
        clock           : in     vl_logic;
        enable          : in     vl_logic;
        zerar           : in     vl_logic;
        max             : in     vl_logic_vector(3 downto 0);
        tete            : out    vl_logic;
        cont            : out    vl_logic_vector(3 downto 0)
    );
end contador;
