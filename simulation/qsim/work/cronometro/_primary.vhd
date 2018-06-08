library verilog;
use verilog.vl_types.all;
entity cronometro is
    port(
        clock1          : in     vl_logic;
        enable1         : in     vl_logic;
        zerar1          : in     vl_logic;
        miliSegundos1   : out    vl_logic_vector(3 downto 0);
        miliSegundos2   : out    vl_logic_vector(3 downto 0);
        Segundos1       : out    vl_logic_vector(3 downto 0);
        Segundos2       : out    vl_logic_vector(3 downto 0);
        Minutos1        : out    vl_logic_vector(3 downto 0);
        Minutos2        : out    vl_logic_vector(3 downto 0)
    );
end cronometro;
