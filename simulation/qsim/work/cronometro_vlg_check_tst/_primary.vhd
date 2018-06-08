library verilog;
use verilog.vl_types.all;
entity cronometro_vlg_check_tst is
    port(
        miliSegundos1   : in     vl_logic_vector(3 downto 0);
        miliSegundos2   : in     vl_logic_vector(3 downto 0);
        Minutos1        : in     vl_logic_vector(3 downto 0);
        Minutos2        : in     vl_logic_vector(3 downto 0);
        Segundos1       : in     vl_logic_vector(3 downto 0);
        Segundos2       : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end cronometro_vlg_check_tst;
