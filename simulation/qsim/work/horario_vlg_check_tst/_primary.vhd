library verilog;
use verilog.vl_types.all;
entity horario_vlg_check_tst is
    port(
        Horas1          : in     vl_logic_vector(3 downto 0);
        Horas2          : in     vl_logic_vector(3 downto 0);
        Minutos1        : in     vl_logic_vector(3 downto 0);
        Minutos2        : in     vl_logic_vector(3 downto 0);
        Segundos1       : in     vl_logic_vector(3 downto 0);
        Segundos2       : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end horario_vlg_check_tst;
