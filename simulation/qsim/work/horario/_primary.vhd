library verilog;
use verilog.vl_types.all;
entity horario is
    port(
        clock1          : in     vl_logic;
        enable1         : in     vl_logic;
        zerar1          : in     vl_logic;
        config          : in     vl_logic;
        strt            : in     vl_logic;
        set             : in     vl_logic;
        Segundos1       : out    vl_logic_vector(3 downto 0);
        Segundos2       : out    vl_logic_vector(3 downto 0);
        Minutos1        : out    vl_logic_vector(3 downto 0);
        Minutos2        : out    vl_logic_vector(3 downto 0);
        Horas1          : out    vl_logic_vector(3 downto 0);
        Horas2          : out    vl_logic_vector(3 downto 0)
    );
end horario;
