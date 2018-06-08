library verilog;
use verilog.vl_types.all;
entity alarme is
    port(
        clock1          : in     vl_logic;
        enable1         : in     vl_logic;
        zerar1          : in     vl_logic;
        config          : in     vl_logic;
        strt            : in     vl_logic;
        set             : in     vl_logic;
        Minutos1        : in     vl_logic_vector(3 downto 0);
        Minutos2        : in     vl_logic_vector(3 downto 0);
        Horas1          : in     vl_logic_vector(3 downto 0);
        Horas2          : in     vl_logic_vector(3 downto 0);
        taNaHora        : out    vl_logic
    );
end alarme;
