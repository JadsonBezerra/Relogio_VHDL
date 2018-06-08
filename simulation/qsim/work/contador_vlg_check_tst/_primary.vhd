library verilog;
use verilog.vl_types.all;
entity contador_vlg_check_tst is
    port(
        cont            : in     vl_logic_vector(3 downto 0);
        tete            : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end contador_vlg_check_tst;
